@tool
@icon("res://addons/inventorytool/icons/inventoryManagerIcon_transparent.png")
extends Control

var _is_selected: bool = true

@onready var list_inventory_editor: PanelContainer = $ListInventoryEditor
@onready var spinbox: SpinBox = %Spinbox
@onready var scroll_container: ScrollContainer = %ScrollContainer
@onready var inventory_slots: VBoxContainer = %inventorySlots

var button_ids = {}  # Dicionário para armazenar os botões e seus IDs

## Atualiza os slots de inventário quando a quantidade é alterada
func _on_inventoryListSize(value: float) -> void:
	inventory_slots.visible = true
	button_ids.clear()
	
	# Limpa completamente os filhos antigos
	for child in inventory_slots.get_children():
		# Remove todas as conexões de sinais primeiro
		if child is Button:
			child.pressed.disconnect(_on_inventory_button_pressed)
		child.queue_free()
	
	# Cria novos blocos com base no valor
	for i in range(int(value)):
		# --- Criação dos elementos ---
		var bloco = PanelContainer.new()
		var margem_bloco = MarginContainer.new()
		var horizontal = HBoxContainer.new()
		var iconPlaceHolder = ColorRect.new()
		
		var item_name = Label.new()
		var item_amount = Label.new()
		var verticalSeparator1 = VSeparator.new()
		var verticalSeparator2 = VSeparator.new()
		var botao = Button.new()
		
		# --- Configuração dos elementos ---
		var current_id = i + 1  # ID único para este botão
		item_name.text = "Item %d" % current_id
		item_amount.text = "Quantidade de item"
		iconPlaceHolder.custom_minimum_size = Vector2(64, 64)
		botao.text = "Ação %d" % current_id
		
		# --- Montagem da hierarquia ---
		bloco.add_child(margem_bloco)
		margem_bloco.add_child(horizontal)
		horizontal.add_child(iconPlaceHolder)
		horizontal.add_child(item_name)
		horizontal.add_child(verticalSeparator1)
		horizontal.add_child(item_amount)
		horizontal.add_child(verticalSeparator2)
		horizontal.add_child(botao)
		
		# --- Conexão do sinal com o ID como parâmetro ---
		botao.pressed.connect(_on_inventory_button_pressed.bind(current_id))
		
		# Armazena o botão no dicionário se precisar acessá-lo depois
		button_ids[current_id] = botao
		
		# Adiciona o bloco à lista principal
		inventory_slots.add_child(bloco)

## Função chamada quando um botão é pressionado
func _on_inventory_button_pressed(id: int) -> void:
	print("Botão pressionado ID:", id)
	
	_open_slot_editor()

@onready var slotEditor = preload("res://addons/inventorytool/ui/inventoryManager.tscn")
## Função chamada quando é clicado no botão do editor de slot
func _open_slot_editor() -> void:
	var window = slotEditor.instantiate()
	get_tree().root.add_child(window)
	
func _ready():
	pass
