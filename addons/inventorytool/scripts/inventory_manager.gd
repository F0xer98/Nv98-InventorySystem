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

# r_slot_master é o template
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

@onready var w_scroll_container: ScrollContainer = $"write atlas/item viewer/W_ScrollContainer"
@onready var w_panel_container: PanelContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer"
@onready var w_organizer: VBoxContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer"
@onready var w_slot_master: MarginContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster"
@onready var w_panel_container_slot: PanelContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot"
@onready var w_edit_vbox: VBoxContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX"

@onready var w_slot_edit: HBoxContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT"
@onready var w_change_icon: Button = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_CHANGE_ICON"

@onready var w_margin_container_editor: MarginContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_MarginContainer_editor"
@onready var w_change_item_name: LineEdit = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_MarginContainer_editor/W_CHANGE_ITEM_NAME"

@onready var w_margin_container_2_editor: MarginContainer = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_MarginContainer2_editor"
@onready var w_change_amount: LineEdit = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_MarginContainer2_editor/W_CHANGE_AMOUNT"

@onready var w_confirm_btn: Button = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_CONFIRM_BTN"

func createNewSlot() -> void:
	
	# Reads itens in .json file
	var items = readJson("res://addons/test/test.json")
	
	# Grants there is anything to process
	if items.is_empty():
		print("JSON VAZIO OU INVÁLIDO")
		return
	
	# Clears previous slots to avoid bugs
	for child in r_grid_container.get_children():
		if child != r_slot_master: # Não remova o slot master original
			child.queue_free()
		print("Limpou slots e filhos de current atlas")
	
	# Gets every item in JSON
	for id in items.keys():
		var item = items[id]
		print("Processando item: ", item)
	
	# Creates a new "R_slotMaster" for EACH item present in .json
	for id in items.keys():
		var item_data = items[id]
		
		# Creates a new instance of R_slotMaster
		var new_slot = r_slot_master.duplicate()
		r_grid_container.add_child(new_slot)
		new_slot.visible = true
		
		# Configures values of "R_slotMaster" with item data and
		# Accesses child nodes using RELATIVE PATH to "new_slot"
		var slot_texture = new_slot.get_node("R_PanelContainer/R_slot/R_TextureRect")
		var slot_id = new_slot.get_node("R_PanelContainer/R_slot/R_MarginContainer/R_ITEM_ID")
		var slot_name = new_slot.get_node("R_PanelContainer/R_slot/R_MarginContainer2/R_ITEM_NAME")
		var slot_amount = new_slot.get_node("R_PanelContainer/R_slot/R_MarginContainer3/R_ITEM_AMOUNT")
		var edit_btn = new_slot.get_node("R_PanelContainer/R_slot/R_PROPERTIES_EDITOR")
		
		# Verifies if nodes are correctly found
		if not slot_texture or not slot_id or not slot_name or not slot_amount or not edit_btn:
			push_error("Alguns nós não foram encontrados para o item ID: " + str(id))
			print("Nós encontrados: ", 
				"Texture: ", slot_texture != null, 
				", ID: ", slot_id != null, 
				", Name: ", slot_name != null, 
				", Amount: ", slot_amount != null, 
				", Edit Button: ", edit_btn != null)
			continue
		
		# Fill the data
		slot_id.text = str(id)
		slot_name.text = item_data.get("NAME", "SEM NOME")
		slot_amount.text = str(item_data.get("AMOUNT", 0))
		
		# If there is a texture on the template, configure it
		if item_data.has("ICON") and item_data["ICON"] != null:
			var icon_path = item_data["ICON"]
			if ResourceLoader.exists(icon_path):
				slot_texture.texture = load(icon_path)
			else:
				print("Ícone não encontrado: ", icon_path)
		
		# Connects the edit_btn's signal
		if edit_btn.is_connected("pressed", _on_edit_properties):
			edit_btn.disconnect("pressed", _on_edit_properties)
		edit_btn.pressed.connect(_on_edit_properties.bind(int(id)))
		
		print("Slot criado com sucesso para o item ID: ", id)

		
func readJson(path: String) -> Dictionary:
	# Limpa os arrays antes de carregar os novos dados
	ID.clear()
	NAME.clear()
	ICON.clear()

	# Tenta abrir o arquivo para leitura
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("Erro ao abrir o arquivo JSON: %s" % path)
		return {}

	# Lê todo o conteúdo como texto
	var text := file.get_as_text()

	# Converte o texto JSON para um objeto do Godot (Dictionary nesse caso)
	var data := JSON.parse_string(text)

	# Garante que o arquivo JSON seja um Dictionary (estrutura correta)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("O JSON precisa ser um Dictionary com os IDs como chaves.")
		return {}

	# Dicionário final com todos os itens
	var result: Dictionary = {}

	# Percorre cada chave do Dictionary (as chaves são os IDs dos itens)
	for id_str in data.keys():
		var item = data[id_str]
		if typeof(item) != TYPE_DICTIONARY:
			print("Item ignorado: não é um dicionário válido.")
			continue

		var id = int(id_str)
		var name = item.get("NAME", "SEM_NOME")
		var icon = item.get("ICON", null)

		# Adiciona nos arrays
		ID.append(id)
		NAME.append(name)
		ICON.append(icon)

		# Adiciona ao dicionário final
		result[id] = {
			"NAME": name,
			"ICON": icon
		}

	return result

	# Debug
	#for i in range(ID.size()):
		#print("Item %d: ID=%d, NAME=%s, ICON=%s" % [i, ID[i], NAME[i], str(ICON[i])])

func writeJson(path: String):
	# Cria um dicionário para armazenar os dados dos itens
	var data := {}

	# Percorre os arrays paralelos (ID, NAME, ICON)
	for i in range(ID.size()):
		# Constrói o dicionário de um item com NAME, AMOUNT e ICON
		var item := {
			"NAME": NAME[i],
			#"AMOUNT": int(w_item_amount.text), # Aqui pegamos o valor direto do campo de UI, se quiser usar outro array, ajuste aqui
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

func _ready():
	load_button.pressed.connect(_on_load_btn_pressed)
	file_dialog.file_selected.connect(_on_selected_file)
	
	r_slot_master.visible = false
	write_atlas.visible = false
func _on_load_btn_pressed():
	file_dialog.popup_centered()
	file_dialog.filters = ["*.json"]  # filters only .json


func _on_selected_file(path: String):
	readJson(path)
	createNewSlot()

var ID : Array = [] #somente int
var NAME : Array = [] #somente strings
var ICON : Array = [] #somente ícones
var AMOUNT: Array = [] 

# edita as propriedades de um item específico
# ao clicar no botão "edit properties"
# abre uma nova janela (write atlas)
# onde há a possibilidade de mudar:
# o ícone, nome do item, e quantidade
# ao aplicar writeJson()
var _currentEditIndex : int = -1 #-1 é o default
func _on_edit_properties() -> void:
	print("Edit properties")
	write_atlas.visible = true
	
func _on_apply_changes() -> void:
	print("apply changes")
	write_atlas.visible = false
