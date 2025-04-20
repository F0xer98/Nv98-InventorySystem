@tool
@icon("res://addons/inventorytool/icons/inventoryManagerIcon_transparent.png")

extends Node
class_name InventoryManager

# --- FILE STRUCTURE ---

# --- ATLAS LOADER ---
@onready var atlas_loader: VBoxContainer = $"read atlas/atlas loader"
@onready var label: Label = $"read atlas/atlas loader/Label"
@onready var load_button: Button = $"read atlas/atlas loader/LoadButton"
@onready var file_dialog: FileDialog = $"read atlas/atlas loader/FileDialog"

# --- CURRENT ATLAS LOADED ---
@onready var current_atlas: VBoxContainer = $"read atlas/current atlas"
@onready var r_scroll_container: ScrollContainer = $"read atlas/current atlas/R_ScrollContainer"
@onready var r_grid_container: GridContainer = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer"

@onready var r_slot_master: MarginContainer = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer/R_slotMaster"
@onready var r_panel_container: PanelContainer = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer/R_slotMaster/R_PanelContainer"

@onready var r_slot: HBoxContainer = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer/R_slotMaster/R_PanelContainer/R_slot"
@onready var r_texture_rect: TextureRect = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer/R_slotMaster/R_PanelContainer/R_slot/R_TextureRect"

@onready var r_margin_container: MarginContainer = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer"
@onready var r_item_id: Label = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer/R_ITEM_ID"

@onready var r_margin_container_2: MarginContainer = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer2"
@onready var r_item_name: Label = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer2/R_ITEM_NAME"

@onready var r_margin_container_3: MarginContainer = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer3"
@onready var r_item_amount: Label = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer3/R_ITEM_AMOUNT"

@onready var r_properties_editor: Button = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer/R_slotMaster/R_PanelContainer/R_slot/R_PROPERTIES_EDITOR"

# --- WRITE ATLAS ---
@onready var write_atlas: VBoxContainer = $"write atlas"
@onready var item_in_atlas: Label = $"write atlas/ITEM_IN_ATLAS"

@onready var item_viewer: VBoxContainer = $"write atlas/item viewer"

@onready var w_scroll_container: ScrollContainer = $"write atlas/item viewer/W_ScrollContainer"
@onready var w_panel_container: PanelContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer"
@onready var w_slot_master: MarginContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster"
@onready var w_panel_container_slot: PanelContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot"

@onready var w_texture_rect: TextureRect = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_slot/W_TextureRect"
@onready var w_margin_container: MarginContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_slot/W_MarginContainer"
@onready var w_item_name: Label = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_slot/W_MarginContainer/W_ITEM_NAME"
@onready var w_margin_container_2: MarginContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_slot/W_MarginContainer2"
@onready var w_item_amount: Label = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_slot/W_MarginContainer2/W_ITEM_AMOUNT"

@onready var w_edit_vbox: VBoxContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX"

@onready var w_slot_edit: HBoxContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT"
@onready var w_change_icon: Button = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_CHANGE_ICON"

@onready var w_margin_container_editor: MarginContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_MarginContainer_editor"
@onready var w_change_item_name: LineEdit = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_MarginContainer_editor/W_CHANGE_ITEM_NAME"

@onready var w_margin_container_2_editor: MarginContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_MarginContainer2_editor"
@onready var w_change_amount: LineEdit = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_MarginContainer2_editor/W_CHANGE_AMOUNT"

@onready var w_confirm_btn: Button = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_CONFIRM_BTN"


func _ready():
	load_button.pressed.connect(_on_load_btn_pressed)
	file_dialog.file_selected.connect(_on_selected_file)

func _on_load_btn_pressed():
	file_dialog.popup_centered()
	file_dialog.filters = ["*.json"]  # filters only .json

func _on_selected_file(path: String):
	print("Arquivo selecionado:", path)
	
	readJson(path)

var ID : Array = [] #somente int
var NAME : Array = [] #somente strings
var ICON : Array = [] #somente ícones
var AMOUNT: Array = [] 

func createNewSlot() -> void:
	# Primeiro limpamos o container pai para evitar duplicatas
	w_panel_container.queue_free_children()  # ou use remove_child() + free manual se preferir controle

	# Iteramos sobre todos os itens carregados do JSON
	for i in ID.size():
		# Clonamos o container base do slot (o mestre escondido usado como template)
		var new_slot = w_slot_master.duplicate()
		new_slot.name = "Slot_" + str(ID[i])
		new_slot.visible = true  # Certifique-se que o clone esteja visível

		# Atualiza os dados visuais do slot clonado
		var texture_rect: TextureRect = new_slot.get_node("W_PanelContainer_Slot/W_slot/W_TextureRect")
		texture_rect.texture = load(ICON[i])  # Carrega a textura do caminho

		var name_label: Label = new_slot.get_node("W_PanelContainer_Slot/W_slot/W_MarginContainer/W_ITEM_NAME")
		name_label.text = NAME[i]

		var amount_label: Label = new_slot.get_node("W_PanelContainer_Slot/W_slot/W_MarginContainer2/W_ITEM_AMOUNT")
		amount_label.text = str(AMOUNT[i])

		# Esconde a parte de edição inicialmente
		var edit_vbox: VBoxContainer = new_slot.get_node("W_PanelContainer_Slot/W_EDIT_VBOX")
		edit_vbox.visible = false

		# Conecta clique no slot (ou botão) para mostrar a edição
		var panel_slot = new_slot.get_node("W_PanelContainer_Slot")
		panel_slot.connect("gui_input", Callable(func(event):
			if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				_show_edit_box_for(i, new_slot)
))
		# Adiciona o novo slot ao painel visual
		w_panel_container.add_child(new_slot)

func _show_edit_box_for(index: int, slot: Control) -> void:
	var edit_vbox = slot.get_node("W_PanelContainer_Slot/W_EDIT_VBOX")
	edit_vbox.visible = true
	w_change_item_name.text = NAME[index]
	w_change_amount.text = str(AMOUNT[index])


func readJson(path: String):
	
	# Limpa os arrays antes de carregar os novos dados
	ID.clear()
	NAME.clear()
	ICON.clear()

	# Tenta abrir o arquivo para leitura
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("Erro ao abrir o arquivo JSON: %s" % path)
		return
	
	# Lê todo o conteúdo como texto
	var text := file.get_as_text()
	
	# Converte o texto JSON para um objeto do Godot (Dictionary nesse caso)
	var data := JSON.parse_string(text)
	
	# Garante que o arquivo JSON seja um Dictionary (estrutura correta)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("O JSON precisa ser um Dictionary com os IDs como chaves.")
		return
	
	# Percorre cada chave do Dictionary (as chaves são os IDs dos itens)
	for id_str in data.keys():
		var item = data[id_str] # Pega o conteúdo de cada item
		if typeof(item) != TYPE_DICTIONARY:
			print("Item ignorado: não é um dicionário válido.")
			continue

		var id = int(id_str)  # Convertendo a chave string para int
		var name = item.get("NAME", "SEM_NOME") # Pega o nome do item, ou "SEM_NOME" se não existir
		var icon = item.get("ICON", null) # Pega o ícone, ou null se não existir
		
		# Adiciona os dados aos arrays
		ID.append(id)
		NAME.append(name)
		ICON.append(icon)

	# Debug
	for i in range(ID.size()):
		print("Item %d: ID=%d, NAME=%s, ICON=%s" % [i, ID[i], NAME[i], str(ICON[i])])

func writeJson(path: String):
	# Cria um dicionário para armazenar os dados dos itens
	var data := {}

	# Percorre os arrays paralelos (ID, NAME, ICON)
	for i in range(ID.size()):
		# Constrói o dicionário de um item com NAME, AMOUNT e ICON
		var item := {
			"NAME": NAME[i],
			"AMOUNT": int(w_item_amount.text), # Aqui pegamos o valor direto do campo de UI, se quiser usar outro array, ajuste aqui
			"ICON": ICON[i]
		}

		# Converte o ID para string, pois o JSON da estrutura original usa strings como chave
		data[str(ID[i])] = item

	# Converte o dicionário completo em uma string JSON formatada
	var json_string := JSON.stringify(data, "\t") # \t para identação legível

	# Tenta abrir o arquivo para escrita
	var file := FileAccess.open(path, FileAccess.WRITE)
	if not file:
		push_error("Erro ao abrir o arquivo para escrita: %s" % path)
		return

	# Escreve a string JSON no arquivo
	file.store_string(json_string)

	# Fecha o arquivo (boa prática)
	file.close()

	# Mensagem de debug
	print("Arquivo salvo com sucesso em: %s" % path)

func _on_edit_properties() -> void:
	pass # Replace with function body.
