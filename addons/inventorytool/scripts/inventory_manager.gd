@tool
@icon("res://addons/inventorytool/icons/inventoryManagerIcon_transparent.png")

extends Node
class_name InventoryManager

var current_json_path: String = "" #holds the path to selected .json file
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

@onready var w_item_label: HBoxContainer = $"write atlas/w_item_label"
@onready var item_in_atlas: Label = $"write atlas/w_item_label/ITEM_IN_ATLAS"
@onready var item_in_atlas_name: Label = $"write atlas/w_item_label/ITEM_IN_ATLAS_NAME"

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

var current_slot_texture : TextureRect = null # References TextureRect from item being edited - MUST BE A GLOBAL VARIABLE

var ID : Array = [] #somente int
var NAME : Array = [] #somente strings
var ICON : Array = [] #somente ícones
var AMOUNT: Array = []  #somente int

func createNewSlot() -> void:
	
	# Reads itens in .json file
	var items = readJson(current_json_path)
	
	# --- ERROR CHECKING ---
	
	# Checks if current path is valid
	if current_json_path.is_empty():
		push_error("Nenhum arquivo JSON selecionado")
		return
		
	# Grants there is anything to process
	if items.is_empty():
		push_error("JSON VAZIO OU INVÁLIDO")
		return
	
	# Clears previous slots to avoid bugs
	for child in r_grid_container.get_children():
		if child != r_slot_master: # Não remova o slot master original
			child.queue_free()
	
	# Gets every item in JSON
	for id in items.keys():
		var item = items[id]
	
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
				
					
		edit_btn.pressed.connect(_on_edit_properties.bind(id)) # conecta o sinal do botão de edição passando ID como parâmetro

func readJson(path: String) -> Dictionary:
	# Limpa os arrays antes de carregar os novos dados
	ID.clear()
	NAME.clear()
	ICON.clear()
	AMOUNT.clear()

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
		var amount = item.get("AMOUNT", 0)
		
		
		# Adiciona nos arrays
		ID.append(id)
		NAME.append(name)
		ICON.append(icon)
		AMOUNT.append(amount)

		# Adiciona ao dicionário final
		result[id] = {
			"NAME": name,
			"ICON": icon
		}

	return result

func writeJson():
	# --- ERROR CHECKING ---
	if current_json_path.is_empty():
		push_error("Nenhum arquivo JSON selecionado")
		return
	
	# Cria um dicionário para armazenar os dados dos itens
	var data := {}

	# Percorre os arrays paralelos (ID, NAME, ICON)
	for i in range(ID.size()):
		# Constrói o dicionário de um item com NAME, AMOUNT e ICON
		var item := {
			"NAME": NAME[i],
			"AMOUNT": int(AMOUNT[i]),
			"ICON": ICON[i]
		}

		# Converte o ID para string
		data[str(ID[i])] = item

	# Converte para string JSON formatada
	var json_string := JSON.stringify(data, "\t")

	# Abre o arquivo selecionado originalmente para escrita
	var file := FileAccess.open(current_json_path, FileAccess.WRITE)
	if not file:
		push_error("Erro ao abrir o arquivo para escrita: %s" % current_json_path)
		return

	# Escreve e fecha o arquivo
	file.store_string(json_string)
	file.close()

	print("Arquivo salvo com sucesso em: %s" % current_json_path)
func _ready():
	load_button.pressed.connect(_on_load_btn_pressed)
	file_dialog.file_selected.connect(_on_selected_file)
	
	r_slot_master.visible = false
	write_atlas.visible = false
	
func _on_load_btn_pressed():
	file_dialog.popup_centered()
	file_dialog.filters = ["*.json"]  # filters only .json

# When selected a .json file, calls readJson() to handle that information
# Then calls createNewSlot() to effectively create a new slot
func _on_selected_file(path: String):
	current_json_path = path # a variável global de caminho do .json recebe o caminho apontado pelo FileDialog
	readJson(path)
	createNewSlot()

func _on_edit_properties(item_id) -> void:
	
	# --- DEBUG ---
	print("Edit properties for ID: ", item_id)
	write_atlas.visible = true
	
	# --- ERROR CHECKING ---
	var index = ID.find(item_id)
	if index == -1:
		push_error("ID não encontrado: ", item_id)
		return
	
	if current_json_path.is_empty():
		push_error("Nenhum arquivo JSON selecionado")
		return
	
	# Carrega os dados do JSON
	var items = readJson(current_json_path)
	if not items.has(str(item_id)):
		push_error("Item ID não encontrado no JSON !")
		return
	
	var item_data = items[str(item_id)]
	
	#encontrar o slot correspondente ao item_id
	for slot in r_grid_container.get_children():
		if slot == r_slot_master:
			continue
		
		var slot_id_text = slot.get_node("R_PanelContainer/R_slot/R_MarginContainer/R_ITEM_ID").text
		
		if int(slot_id_text) == item_id:
			current_slot_texture = slot.get_node("R_PanelContainer/R_slot/R_TextureRect")
			break
	
	
	# --- PREENCHE OS CAMPOS DE EDIÇÃO ---
	#item_in_atlas_name.text = NAME[index]
	#w_change_amount.text = str(AMOUNT[index])
	
	item_in_atlas_name.text = "Editando: " + item_data.get("NAME", "Sem Nome")
	w_change_item_name.text = item_data.get("NAME", "")
	w_change_amount.text = str(item_data.get("AMOUNT", 0))
	
	# --- CONEXÃO DOS BOTÕES ---
	
	# Botão de confirmar mudanças
	if w_confirm_btn.pressed.is_connected(_on_apply_changes):
		w_confirm_btn.pressed.disconnect(_on_apply_changes)
		w_confirm_btn.pressed.connect(_on_apply_changes.bind(item_id))
	
	
	# Botão de mudar ícone
	if w_change_icon.pressed.is_connected(_on_change_icon):
		w_change_icon.pressed.disconnect(_on_change_icon)
	w_change_icon.pressed.connect(_on_change_icon.bind(item_id))
	
	print("Alterou o json")
	
func _on_apply_changes() -> void:
	print("apply changes")
	write_atlas.visible = false

func _on_change_icon() -> void:
	
	print("Mudar de ícone") # --- DEBUG ---
	
	if not current_slot_texture:
		push_error("Nenhum slot selecionado para trocar ícone")
		return
	
	#Criar um FileDialog temporário
	var file_dialog = FileDialog.new()
	
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.access = FileDialog.ACCESS_RESOURCES
	file_dialog.filters = ["*.png", "*.jpg", "*.jpeg"]
	
	file_dialog.files_selected.connect(func(path): # função lambda pra economizar espaço
		if ResourceLoader.exists(path):
			var new_texture = load(path)
			current_slot_texture.texture = new_texture
			
			var index = ID.find((int(current_slot_texture.get_parent().get_parent().get_node("R_MarginContainer/R_ITEM_ID").text)))
			
			if index != -1:
				ICON[index] = path
		
		file_dialog.queue_free()
		)
	add_child(file_dialog)
	file_dialog.popup_centered_ratio()
