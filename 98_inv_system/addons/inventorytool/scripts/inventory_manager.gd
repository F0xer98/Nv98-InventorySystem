@tool
extends Control

var _is_selected: bool = true

@onready var grid_inventory_editor: PanelContainer = $GridInventoryEditor
@onready var list_inventory_editor: PanelContainer = $ListInventoryEditor

## Simple type of inventory selector
func _on_inventory_type(index: int) -> void:
	if index == 0: # for grid inventory
		grid_inventory_editor.visible = _is_selected
		list_inventory_editor.visible = not _is_selected
	elif index == 1: # for list inventory
		grid_inventory_editor.visible = not _is_selected
		list_inventory_editor.visible = _is_selected

@onready var spinbox: SpinBox = %Spinbox
@onready var scroll_container: ScrollContainer = %ScrollContainer
@onready var inventory_slots: VBoxContainer = %inventorySlots

## Updates inventory slots each time the "amount of slots" is changed
func _on_inventoryListSize(value: float) -> void:
	print(value)
	inventory_slots.visible = true
	
	# Limpa a lista antes de recriar os slots
	for child in inventory_slots.get_children():
		child.queue_free()
	
	# Cria os blocos com base no valor
	for i in range(int(value)):
		
		var bloco = PanelContainer.new() # pai de margin_container
		var margem_bloco = MarginContainer.new() # pai de hboxcontainer
		var horizontal = HBoxContainer.new() # pai de icon placeholder
		var iconPlaceHolder = ColorRect.new() #placeholder pro ícone - tamanho mínimo 64x64 px
		
		var item_name = Label.new()
		var item_amount = Label.new()
		
		var verticalSeparator1 = VSeparator.new()
		var verticalSeparator2 = VSeparator.new()
		
		var botao = Button.new()
		
		item_name.text = "item name"
		item_amount.text = "item amount"
		
		bloco.add_child(margem_bloco)
		margem_bloco.add_child(horizontal)
		horizontal.add_child(iconPlaceHolder)
		iconPlaceHolder.custom_minimum_size = Vector2(64, 64)
		
		horizontal.add_child(item_name)
		horizontal.add_child(verticalSeparator1)
		horizontal.add_child(item_amount)
		horizontal.add_child(verticalSeparator2)
		horizontal.add_child(botao)

		
		botao.text = "Botão de ação"
		botao.pressed.connect(func():
			print("Botão do item %d pressionado" % (i + 1))
		)

		# Adiciona o bloco à lista principal (agora corretamente)
		inventory_slots.add_child(bloco)

func _ready():
	spinbox.value_changed.connect(_on_inventoryListSize)
	inventory_slots.visible = false
	
