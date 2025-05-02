@tool
@icon("res://addons/inventorytool/icons/inventoryManagerIcon_transparent.png")

extends Node
class_name InventoryManager

# --- FILE STRUCTURE ---

# --- CREATE ATLAS ---
@onready var create_atlas: VBoxContainer = $"create atlas"
@onready var create_button: Button = $"create atlas/CreateButton" # used to popup the FileDialog
@onready var create_h_box_container: HBoxContainer = $"create atlas/HBoxContainer"
@onready var new_slot_btn: Button = $"create atlas/HBoxContainer/NewSlotBtn"
@onready var delete_slot_btn: Button = $"create atlas/HBoxContainer/DeleteSlotBtn"
@onready var apply_changes_btn: Button = $"create atlas/HBoxContainer/ApplyChangesBtn"
@onready var create_scroll_container: ScrollContainer = $"create atlas/CreateScrollContainer"
@onready var scroll_vbox: VBoxContainer = $"create atlas/CreateScrollContainer/scrollVbox"
@onready var slot_template: MarginContainer = $"create atlas/CreateScrollContainer/scrollVbox/slotTemplate" #template to display

# Moved create_file_dialog outside the template for clarity
@onready var create_file_dialog: FileDialog = $"create atlas/createFileDialog"


# --- CURRENT ATLAS VISUALIZER (for Create Atlas) ---
@onready var current_atlas_visualizer: VBoxContainer = $"create atlas/current atlas visualizer"
@onready var c_slotmaster_template: MarginContainer = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE" # template for display
@onready var c_icon: TextureRect = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX/C_ICON"
@onready var c_item_id: Label = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX/C_ID_MARGIN/C_ITEM_ID"
@onready var c_item_name: Label = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX/C_NAME_MARGIN/C_ITEM_NAME"
@onready var c_max_stack: Label = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX/C_MAX_STACK_MARGIN/C_MAX_STACK"


# --- ATLAS LOADER ---
@onready var atlas_loader: VBoxContainer = $"read atlas/atlas loader"
@onready var load_button: Button = $"read atlas/atlas loader/LoadButton"
@onready var jsonLoader: FileDialog = $"read atlas/atlas loader/jsonLoader"
@onready var r_slot_master: MarginContainer = $"read atlas/atlas loader/R_slotMaster"
@onready var r_texture_rect: TextureRect = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_TextureRect"
@onready var r_item_id: Label = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer/R_ITEM_ID"
@onready var r_item_name: Label = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer2/R_ITEM_NAME"
@onready var r_item_amount: Label = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer3/R_ITEM_AMOUNT"
@onready var r_properties_editor: Button = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_PROPERTIES_EDITOR"


# --- CURRENT ATLAS LOADED ---
@onready var current_atlas: VBoxContainer = $"read atlas/current atlas"
@onready var r_scroll_container: ScrollContainer = $"read atlas/current atlas/R_ScrollContainer"
@onready var r_grid_container: GridContainer = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer"

# --- WRITE ATLAS ---
@onready var write_atlas: VBoxContainer = $"write atlas"
@onready var item_in_atlas: Label = $"write atlas/w_item_label/ITEM_IN_ATLAS"
@onready var item_in_atlas_name: Label = $"write atlas/w_item_label/ITEM_IN_ATLAS_NAME"
@onready var w_change_icon: Button = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_CHANGE_ICON"
@onready var w_change_item_name: LineEdit = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_MarginContainer_editor/W_CHANGE_ITEM_NAME"
@onready var w_change_amount: LineEdit = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_MarginContainer2_editor/W_CHANGE_AMOUNT"
@onready var w_confirm_btn: Button = $"write atlas/item viewer/W_ScrollContainer/W_PanelContainer/W_organizer/W_slotMaster/W_PanelContainer_Slot/W_EDIT_VBOX/W_SLOT_EDIT/W_CONFIRM_BTN"


var current_slot_texture : TextureRect = null # References TextureRect from item being edited - MUST BE A GLOBAL VARIABLE
var edit_json_path: String = "" #holds the path to selected .json file
var create_json_path: String = "" # hold the path to a new atlas

#arrays usados PARA EDIÇÃO DE ATLAS
var edit_ID : Array[int] = [] #somente int
var edit_NAME : Array[String] = [] #somente strings
var edit_ICON : Array = [] #somente ícones
var edit_AMOUNT: Array = []


# arrays usados PARA CRIAÇÃO DE NOVO ATLAS
var create_ID : Array[int] = [] #somente int
var create_NAME : Array[String] = [] #somente strings
var create_ICON : Array = [] #somente ícones
var create_AMOUNT: Array = []

# used in both createNewAtlas and _on_new_slot_created
var current_slots : Array = [] # Holds references to the instantiated slotTemplate nodes
var selected_slot = null


func _ready() -> void:
	
	# Hides UI as default
	r_slot_master.visible = false
	write_atlas.visible = false
	create_scroll_container.visible = false
	create_h_box_container.visible = false
	#slot_template.visible = false # Hide the original template


# --- DEDICATED AREA TO MODIFY AN EXISTING .JSON ---



## This fuction switches on and off the create mode for a new .json
## If pressed the "Create new item atlas" create mode goes on, click again to turn off
## This is to make sure no errors would happen during the "create json" or "edit json" develop phase
func createNewAtlas() -> void:
	
	# Altera a visibilidade da área de criação
	create_h_box_container.visible = not create_h_box_container.visible # os botões de criar / deletar slot
	create_scroll_container.visible = not create_scroll_container.visible # para modo de edição
	
	# Só entra no modo edição se a janela estiver aberta para evitar problemas
	if create_scroll_container.visible:
		print("Modo criação de atlas")
		
		# Clears the state of the Create Atlas section (arrays and UI)
		_clear_create_atlas_state()
		
		# Path to where the .json will be saved, keep as it is, will be defined when saving
		create_json_path = ""
		
	# sai do modo edição
	else:
		print("Criação de atlas desativado")
		_clear_create_atlas_state() # Clears state when closing as well

## Clears the state of the Create Atlas section (arrays and UI)
func _clear_create_atlas_state():
	# Clear arrays
	create_ID.clear()
	create_NAME.clear()
	create_ICON.clear()
	create_AMOUNT.clear()
	
	# Clear UI slots
	for slot_node in current_slots:
		if is_instance_valid(slot_node):
			slot_node.queue_free()
	current_slots.clear()
	
	# Reset visualizer (optional, depends on desired behavior) -> to be enhanced
	# current_atlas_visualizer.visible = false 
	# c_item_id.text = "--"
	# c_item_name.text = "--"
	# c_max_stack.text = "--"
	# c_icon.texture = null
	
	# Disables apply button if no slots exist
	apply_changes_btn.disabled = current_slots.is_empty()


# ---##### FUNCTIONS RELATED TO #####---
# ---#####  LOAD ITEM ATLAS  #####---


## Loads info from an supported .json format and display them on "Load Item Atlas" and apply to the UI
func createLoadSlot() -> void:
	print("createLoadSlot")
	
	# Reads itens from an already existing .json file
	var items = loadJsonAtlas(edit_json_path)
	
	# --- ERROR CHECKING ---
	
	# Checks if current path is invalid
	if edit_json_path.is_empty():
		push_error("Nenhum arquivo JSON selecionado")
		return
		
	# Grants there is anything inside that .json to process
	if items.is_empty():
		push_warning("Arquivo JSON está vazio ou não contém itens válidos: ", edit_json_path)
		# Clear previous slots if any exists
		for child in r_grid_container.get_children():
			if child != r_slot_master: # Do not remove the original template
				child.queue_free()
		return
	
	# Clears previous slots to avoid bugs
	for child in r_grid_container.get_children():
		if child != r_slot_master: # Do not remove the original template
			child.queue_free()
	
	# Creates a new "R_slotMaster" for EACH item present in the .json
	for id_str in items.keys(): # Iterate using string keys from JSON
		var item_data = items[id_str]
		var item_id = int(id_str) # Convert to int for internal use
		
		# Creates a new instance of R_slotMaster
		var new_slot = r_slot_master.duplicate()
		r_grid_container.add_child(new_slot)
		new_slot.visible = true
		
		# Configures values of "R_slotMaster" with item data and
		# Access child nodes using RELATIVE PATH to "new_slot"
		var slot_texture = new_slot.get_node("R_PanelContainer/R_slot/R_TextureRect")
		var slot_id_label = new_slot.get_node("R_PanelContainer/R_slot/R_MarginContainer/R_ITEM_ID")
		var slot_name_label = new_slot.get_node("R_PanelContainer/R_slot/R_MarginContainer2/R_ITEM_NAME")
		var slot_amount_label = new_slot.get_node("R_PanelContainer/R_slot/R_MarginContainer3/R_ITEM_AMOUNT")
		var edit_btn = new_slot.get_node("R_PanelContainer/R_slot/R_PROPERTIES_EDITOR")
		
		# Verifies if nodes are correctly found
		if not slot_texture or not slot_id_label or not slot_name_label or not slot_amount_label or not edit_btn:
			push_error("Alguns nós não foram encontrados para o item ID: " + str(item_id))
			continue
		
		# Fill the data
		slot_id_label.text = str(item_id)
		slot_name_label.text = item_data.get("NAME", "SEM NOME")
		slot_amount_label.text = str(item_data.get("AMOUNT", 0))
		
		# If there is a texture on the template, configure it
		if item_data.has("ICON") and item_data["ICON"] != null and item_data["ICON"] != "":
			var icon_path = item_data["ICON"]
			if ResourceLoader.exists(icon_path):
				slot_texture.texture = load(icon_path)
			else:
				print("Ícone não encontrado: ", icon_path)
				slot_texture.texture = null # Clear texture if path is invalid
		else:
			slot_texture.texture = null # No icon specified
			
		# conecta o sinal do botão de edição passando ID como parâmetro (int)
		# Ensure previous connections are removed if any (though duplication should handle this)
		if edit_btn.pressed.is_connected(_on_edit_properties):
			edit_btn.pressed.disconnect(_on_edit_properties)
		edit_btn.pressed.connect(_on_edit_properties.bind(item_id))


## Reads the json selected by the "Load item atlas" button
func loadJsonAtlas(path: String) -> Dictionary:
	# Limpa os arrays de edição antes de carregar os novos dados
	edit_ID.clear()
	edit_NAME.clear()
	edit_ICON.clear()
	edit_AMOUNT.clear()

	# Tenta abrir o arquivo para leitura
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("Erro ao abrir o arquivo JSON: %s. Erro: %s" % [path, error_string(FileAccess.get_open_error())])
		return {}

	# Lê todo o conteúdo como texto
	var text := file.get_as_text()
	file.close() # Close the file after reading

	# Check if text is empty
	if text.is_empty():
		print("Arquivo JSON está vazio: %s" % path)
		return {}

	# Converte o texto JSON para um objeto do Godot (Dictionary nesse caso)
	var parse_result := JSON.parse_string(text)

	# Check for parsing errors
	if parse_result == null:
		push_error("Erro ao parsear JSON do arquivo: %s." % path)
		# Consider printing the JSON error details if available in newer Godot versions
		return {}

	# Garante que o resultado seja um Dictionary
	if typeof(parse_result) != TYPE_DICTIONARY:
		push_error("O JSON precisa ser um Dictionary com os IDs como chaves. Tipo encontrado: %s" % typeof(parse_result))
		return {}

	var data: Dictionary = parse_result
	var result: Dictionary = {} # Dictionary to return (consistent with original structure)

	# Percorre cada chave do Dictionary (as chaves são os IDs dos itens, expected as strings)
	for id_str in data.keys():
		# Validate ID format (should be convertible to int)
		if not id_str.is_valid_int():
			print("Chave JSON ignorada: não é um inteiro válido ('%s')." % id_str)
			continue
		
		var item = data[id_str]
		if typeof(item) != TYPE_DICTIONARY:
			print("Item ignorado (ID: %s): não é um dicionário válido." % id_str)
			continue

		var id_int = int(id_str)
		var name = item.get("NAME", "SEM_NOME")
		var icon = item.get("ICON", "") # Default to empty string
		var amount = item.get("AMOUNT", 0)
		
		# Adiciona nos arrays de edição
		edit_ID.append(id_int)
		edit_NAME.append(name)
		edit_ICON.append(icon)
		edit_AMOUNT.append(amount)

		# Adiciona ao dicionário final (para createLoadSlot)
		result[id_str] = {
			"NAME": name,
			"ICON": icon,
			"AMOUNT": amount # Include amount here as well
		}

	return result


## When selected a .json file, calls readJson() to read that information and store to be used on
## loadJsonAtlas() to effectively create a new slot on Load Item Atlas
func _on_selected_file(path: String) -> void:
	
	var items = loadJsonAtlas(path) # Populates ID, NAME, ICON, AMOUNT arrays
	edit_json_path = path # a variável global de caminho do .json recebe o caminho apontado pelo FileDialog
	
	if not items.is_empty() or FileAccess.file_exists(path): # Proceed if items were read or file exists (even if empty)
		createLoadSlot() # Uses the populated arrays implicitly via readJson
	else:
		# Clear the grid if the file couldn't be read or doesn't exist
		for child in r_grid_container.get_children():
			if child != r_slot_master:
				child.queue_free()


## When clicked on "Load Item Atlas" button, calls the loading screen and filters by only .json
func _on_load_btn_pressed() -> void:
	jsonLoader.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	jsonLoader.access = FileDialog.ACCESS_RESOURCES # Or ACCESS_USERDATA depending on where files are
	jsonLoader.filters = ["*.json ; JSON Atlas Files"]
	jsonLoader.popup_centered()


## When clicked on the "change icon" on load item atlas
func _on_edit_icon(item_id: int) -> void:
	print("Mudar de ícone para o item ID: ", item_id) # --- DEBUG ---
	
	# This function needs implementation - likely open another FileDialog
	# to select an image and update the ICON array and current_slot_texture
	
	# Placeholder: Needs FileDialog to select image, then update ICON[index] and texture
	var index = edit_ID.find(item_id)
	if index < 0:
		push_error("ID não encontrado ao tentar editar ícone: ", item_id)
		return
	
	# Example: Open file dialog, on file selected, update ICON[index] and texture
	# jsonLoader_icon.popup_centered()
	# jsonLoader_icon.file_selected.connect(_on_icon_file_selected.bind(index))


## Gets an an already existing .json and modifies it via Load Item Atlas
func writeJson():
	
	# --- ERROR CHECKING ---
	if edit_json_path.is_empty():
		push_error("Nenhum arquivo JSON selecionado para salvar as edições.")
		return
	
	if edit_ID.is_empty():
		# This might be valid if the user deleted all items
		print("Arrays de edição estão vazios. Salvando um JSON vazio.")
		# Allow saving an empty JSON
	
	var json_data : Dictionary = {}
	
	# Preenche os dados NO ARQUIVO .JSON a partir dos arrays de EDIÇÃO
	for i in range(edit_ID.size()):
		# Basic range check (shouldn't happen if loops are correct)
		if i >= edit_NAME.size() or i >= edit_AMOUNT.size() or i >= edit_ICON.size():
			push_error("Erro de sincronia nos arrays de edição no índice: ", i)
			continue
			
		var item_id = edit_ID[i]
		var item_name = edit_NAME[i]
		var item_amount = edit_AMOUNT[i] # Should already be int from editing
		var item_icon = edit_ICON[i]
		
		# Constrói cada item do inventário
		var item_data : Dictionary = {
			"NAME": item_name,
			"AMOUNT": item_amount,
			"ICON": item_icon if item_icon != null else ""
		}
		
		# Adiciona ao dicionário principal usando ID como chave string
		json_data[str(item_id)] = item_data
	
	# Converte para JSON formatado
	var json_string = JSON.stringify(json_data, "\t", false, true)
	
	# Escreve no arquivo .json selecionado
	var file : FileAccess = FileAccess.open(edit_json_path, FileAccess.WRITE)
	if not file:
		push_error("Falha ao abrir arquivo para escrita: %s. Erro: %s" % [edit_json_path, error_string(FileAccess.get_open_error())])
		return
	
	file.store_string(json_string)
	file.close()
	
	print("Atlas (editado) salvo com sucesso em: ", edit_json_path)
	print("Total de itens salvos: ", json_data.size())


## Triggered when pressing the "apply button on "edit properties" from Load Item Atlas
func _on_apply_changes(item_id: int) -> void:
	print("Aplicando mudanças (edição) para o item ID: ", item_id)
	
	# Find the index in the EDIT arrays
	var index = edit_ID.find(item_id)
	
	# --- ERROR VERIFICATION ---
	if index < 0:
		push_error("ID não encontrado nos arrays internos ao aplicar mudanças (edição): ", item_id)
		write_atlas.visible = false # Hide editor on error
		return
	
	# --- VALIDATE INPUTS --- 
	var new_name = w_change_item_name.text
	var amount_text = w_change_amount.text
	
	if new_name.is_empty():
		push_warning("Nome do item não pode ser vazio.")
		# Optionally provide visual feedback to the user
		return
	
	if not amount_text.is_valid_int():
		push_warning("Quantidade inválida: '%s'. Deve ser um número inteiro." % amount_text)
		return
		
	var new_amount = int(amount_text)
	if new_amount < 0:
		push_warning("Quantidade não pode ser negativa.")
		return

	# --- UPDATES EDIT ARRAYS WITH NEW VALUES ---
	edit_NAME[index] = new_name
	edit_AMOUNT[index] = new_amount
	# ICON[index] should be updated by _on_edit_icon's callback
	
	# --- UPDATE VISUAL SLOT IN THE GRID ---
	var slot_updated = false
	for slot in r_grid_container.get_children():
		if slot == r_slot_master:
			continue
		
		var slot_id_label = slot.get_node_or_null("R_PanelContainer/R_slot/R_MarginContainer/R_ITEM_ID")
		
		if slot_id_label and slot_id_label.text == str(item_id):
			var name_label = slot.get_node_or_null("R_PanelContainer/R_slot/R_MarginContainer2/R_ITEM_NAME")
			var amount_label = slot.get_node_or_null("R_PanelContainer/R_slot/R_MarginContainer3/R_ITEM_AMOUNT")
			# Icon texture should be updated by the icon change logic
			
			if name_label: name_label.text = edit_NAME[index]
			if amount_label: amount_label.text = str(edit_AMOUNT[index])
			
			slot_updated = true
			break # Found the slot, no need to continue loop
	
	if not slot_updated:
		push_warning("Slot visual correspondente ao ID %d não encontrado para atualização." % item_id)

	# --- SAVE CHANGES TO .JSON FILE ---
	writeJson() # Save the entire current state of ID, NAME, AMOUNT, ICON arrays
	
	# --- CLEANUP ---
	write_atlas.visible = false # Hide the editor panel
	print("Alterações salvas com sucesso para o item ID: ", item_id)


## Triggers when click on "edit properties"" on the load item atlas
func _on_edit_properties(item_id: int) -> void:

	# Find the index in the EDIT arrays
	var index = edit_ID.find(item_id)
	print("Editando item ID: %d, Índice no array: %d" % [item_id, index])
	
	# --- ERROR CHECKING ---
	if index < 0:
		push_error("ID %d não encontrado nos arrays de edição." % item_id)
		return
	
	# Check if arrays have data for this index (sanity check)
	if index >= edit_NAME.size() or index >= edit_AMOUNT.size() or index >= edit_ICON.size():
		push_error("Erro de sincronia nos arrays de edição para índice %d." % index)
		return
		
	# --- PREENCHE OS CAMPOS DE EDIÇÃO using data from arrays ---
	var current_name = edit_NAME[index]
	var current_amount = edit_AMOUNT[index]
	# var current_icon_path = ICON[index] # Icon path is stored here

	item_in_atlas_name.text = "Editando: " + current_name # Display current name
	w_change_item_name.text = current_name
	w_change_amount.text = str(current_amount)
	
	# Find the corresponding visual slot's TextureRect to potentially update its texture later
	# This reference is needed if _on_edit_icon modifies the texture directly
	current_slot_texture = null # Reset before searching
	for slot in r_grid_container.get_children():
		if slot == r_slot_master:
			continue
		var slot_id_label = slot.get_node_or_null("R_PanelContainer/R_slot/R_MarginContainer/R_ITEM_ID")
		if slot_id_label and slot_id_label.text == str(item_id):
			current_slot_texture = slot.get_node_or_null("R_PanelContainer/R_slot/R_TextureRect")
			break
	
	if not current_slot_texture:
		push_warning("TextureRect não encontrado para o slot de edição ID: %d" % item_id)

	# --- CONEXÃO DOS BOTÕES (Disconnect first to avoid multiple connections) ---
	
	# Botão de confirmar mudanças
	if w_confirm_btn.pressed.is_connected(_on_apply_changes):
		w_confirm_btn.pressed.disconnect(_on_apply_changes)
	w_confirm_btn.pressed.connect(_on_apply_changes.bind(item_id))
	
	# Botão de mudar ícone
	if w_change_icon.pressed.is_connected(_on_edit_icon):
		w_change_icon.pressed.disconnect(_on_edit_icon)
	w_change_icon.pressed.connect(_on_edit_icon.bind(item_id))

	# --- SHOW EDITOR ---
	write_atlas.visible = true


# ---##### FUNCTIONS RELATED TO #####---
# ---#####  CREATE NEW ITEM ATLAS  #####---

## Creates a new UI slow and add default data into the create_* arrays
## create_ID // create_NAME // create_AMOUNT // create_ICON
## It doesnt immediately saves the .json

## Starting point of Create New Item Atlas
func createAtlasSlot() -> void:
	print( "Creating a new item slot (for UI and arrays) " )
	
	# Habilita o botão de aplicar e mostra a área de criação (se não visível)
	apply_changes_btn.disabled = false
	create_scroll_container.visible = true
	
	# Duplica a instância do slotTemplate e adiciona a ui
	var new_slot_node = slot_template.duplicate()
	new_slot_node.visible = true
	# Ensure unique name if needed for finding later, though array index is better
	new_slot_node.name = "CreateSlot_%d" % current_slots.size() 
	scroll_vbox.add_child(new_slot_node)
	current_slots.append(new_slot_node)
	
	# Calcula um ID único (simplesmente o índice atual)
	var new_id = create_ID.size() # ID será 0, 1, 2, ...
	var default_name = "NOVO_ITEM_%d" % new_id
	var default_amount = 1 # Default amount/stack size
	var default_icon = "" # string vazia = sem ícone definido
	
	# Adiciona dados Padrão aos arrays de CRIAÇÃO
	create_ID.append(new_id)
	create_NAME.append(default_name)
	create_AMOUNT.append(default_amount)
	create_ICON.append(default_icon)
	
	# --- Configura os campos no NOVO SLOT DA UI --- 
	# Use get_node relative to new_slot_node
	var id_edit = new_slot_node.get_node_or_null("VBoxContainer/mainItemHolder/addIDToJson")
	var name_edit = new_slot_node.get_node_or_null("VBoxContainer/mainItemHolder/addNameToJson")
	var amount_edit = new_slot_node.get_node_or_null("VBoxContainer/mainItemHolder/Item amount")
	var icon_button = new_slot_node.get_node_or_null("VBoxContainer/mainItemHolder/addIconToJson")
	# var icon_preview = new_slot_node.get_node_or_null("VBoxContainer/mainItemHolder/??IconPreview??") # Need a preview TextureRect

	if id_edit:
		id_edit.text = str(new_id)
		# Make ID read-only if it's auto-generated and shouldn't be changed by user
		# id_edit.editable = false 
	if name_edit: name_edit.text = default_name
	if amount_edit: amount_edit.text = str(default_amount)
	
	
	# Icon setup needs more logic: connect icon_button, handle file selection, update create_ICON array and preview
	if icon_button:
		# Connect button press to a function that opens file dialog for this specific slot
		# Example: icon_button.pressed.connect(_on_create_icon_button_pressed.bind(new_id)) 
		pass # Placeholder for icon button connection
	
	# --- Atualiza o visualizador (opcional, pode ser removido se confuso) ---
	current_atlas_visualizer.visible = true
	c_item_id.text = str(new_id)
	c_item_name.text = default_name
	c_max_stack.text = str(default_amount)
	c_icon.texture = load("res://addons/inventorytool/icons/placeHolder.png") # Placeholder
	
	print("Slot UI criado para ID (índice): %d. Total de slots: %d" % [new_id, current_slots.size()])
	print("Arrays create_*: ", create_ID, create_NAME, create_AMOUNT, create_ICON)


## Deletes the LAST slot created slot on "create new item atlas"
func deleteAtlasSlot() -> void:
	
	# Se não tiver slot novo, não faz nada
	if current_slots.is_empty():
		print("Nenhum slot para apagar")
		apply_changes_btn.disabled = true # Ensure button is disabled
		return
	
	# Pega o último slot da UI que foi adicionado
	var last_slot_node = current_slots.pop_back()
	
	# Remove ele da cena e libera memória
	if is_instance_valid(last_slot_node):
		last_slot_node.queue_free()

	# Remove os dados do ÚLTIMO item dos arrays de criação
	if not create_ID.is_empty(): create_ID.pop_back()
	if not create_NAME.is_empty(): create_NAME.pop_back()
	if not create_ICON.is_empty(): create_ICON.pop_back()
	if not create_AMOUNT.is_empty(): create_AMOUNT.pop_back()
	
	print("Último slot apagado. Restam %d slots." % current_slots.size())
	print("Arrays create_*: ", create_ID, create_NAME, create_AMOUNT, create_ICON)
	
	# Desabilita o botão de salvar se não houver mais slots
	if current_slots.is_empty():
		apply_changes_btn.disabled = true


## Chamado quando um arquivo é selecionado no FileDialog de CRIAÇÃO
func _on_create_file_selected(path: String) -> void:
	# guarda o caminho para futuras salvamentos
	create_json_path = path
	print("O novo atlas será salvo em: ", path)
	
	# *** AQUI é o ponto crucial: Atualizar os arrays ANTES de salvar ***
	_update_create_arrays_from_ui() 
	
	# Agora sim, serializar e gravar o JSON com dados atualizados
	saveCreateAtlasToJson(create_json_path)

## Specifically a function to begin the process of saving a new .json
## Called when pressed the Apply Changes on Create new item atlas
func _on_new_apply_changes() -> void:
	# First updates the arrays
	_update_create_arrays_from_ui()
	
	# Verifies if there is any item to save
	if create_ID.is_empty():
		push_warning("Não há itens para salvar no novo atlas.")
		# Optionally show a message to the user via UI -> to do
		return

	# Opens a new dialog to choose where .json is gonna be saved
	# It doesnt imediately saves here, it used _on_create_file_selected()
	
	create_file_dialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
	create_file_dialog.access = FileDialog.ACCESS_RESOURCES #only res://...
	create_file_dialog.filters = ["*.json ; JSON Atlas File"] #only .json
	create_file_dialog.dialog_hide_on_ok = true # Hides dialog on OK
	
	# Connects signal BEFORE showing popup if not connected before (happened some bugs before, <keep this here>)
	if not create_file_dialog.file_selected.is_connected(_on_create_file_selected):
		create_file_dialog.file_selected.connect(_on_create_file_selected)
	
	create_file_dialog.popup_centered()


## Reads UI data and updates all the create_* arrays for the create new item atlas
## Called by _on_new_apply_changes and _on_create_file_selected
func _update_create_arrays_from_ui() -> void:
	print("_update_create_arrays_from_ui(): Atualizando os arrays create_* a partir da UI...")
	
	# Recovering might be complex, better to stop or to clean
	if current_slots.size() != create_ID.size():
		push_error("Erro de sincronia! Número de slots na UI (%d) diferente do tamanho dos arrays create_ID (%d)." % [current_slots.size(), create_ID.size()])
		return

	for i in range(current_slots.size()):
		var slot_node = current_slots[i]
		if not is_instance_valid(slot_node):
			push_warning("Slot inválido encontrado no índice %d durante a atualização." % i)
			continue

		# Acessa os LineEdits dentro do slot_node atual
		# Ajusta os caminhos conforme a estrutura EXATA do slotTemplate
		var id_edit = slot_node.get_node_or_null("VBoxContainer/mainItemHolder/addIDToJson")
		var name_edit = slot_node.get_node_or_null("VBoxContainer/mainItemHolder/addNameToJson")
		var amount_edit = slot_node.get_node_or_null("VBoxContainer/mainItemHolder/Item amount")
		# Icon path precisa ser tratado separadamente, talvez armazenado no próprio slot_node ou lido de outra forma

		# --- Lê os valores da UI --- 
		var ui_id_str = id_edit.text if id_edit else str(create_ID[i]) # Pega ID da UI ou mantém o original
		var ui_name = name_edit.text if name_edit else create_NAME[i] # Pega nome da UI ou mantém o original
		var ui_amount_str = amount_edit.text if amount_edit else str(create_AMOUNT[i]) # Pega amount da UI ou mantém o original
		var ui_icon # Precisa buscar o CAMINHO do ícone associado a este slot

		# --- Valida e Atualiza os Arrays open for more info --- 
		# ID (Opcional: só atualiza se for editável, senão ignora o ui_id_str)
		# if id_edit and id_edit.editable and ui_id_str.is_valid_int():
		#    create_ID[i] = int(ui_id_str)
		# else: I i
		#    # Mantém o ID original se não for editável ou inválido
		#    pass 
		
		if ui_name.is_empty():
			print("Aviso: Nome vazio para o item no índice %d. Usando nome anterior: '%s'" % [i, create_NAME[i]])
		else:
			create_NAME[i] = ui_name

		if ui_amount_str.is_valid_int():
			var amount_val = int(ui_amount_str)
			if amount_val >= 0:
				create_AMOUNT[i] = amount_val
			else:
				print("Aviso: Quantidade negativa ('%s') inválida para o item no índice %d. Usando valor anterior: %d" % [ui_amount_str, i, create_AMOUNT[i]])
		else:
			print("Aviso: Quantidade inválida ('%s') para o item no índice %d. Usando valor anterior: %d" % [ui_amount_str, i, create_AMOUNT[i]])

		# Atualizar create_ICON[i] aqui baseado em como o caminho do ícone é gerenciado para cada slot
		# create_ICON[i] = slot_node.get_meta("icon_path", create_ICON[i]) # Se você guardar em meta-data

	print("Arrays create_* atualizados: ", create_ID, create_NAME, create_AMOUNT, create_ICON)


## Responsável por atualizar o current atlas visualizer (Placeholder)
func _on_hover_new_atlas_creator() -> void:
	# por fazer ainda, só um placeholder por enquanto
	pass

# --- FUNÇÕES AUXILIARES PARA CRIAÇÃO --- 


## Just generates a dictionary ready for json from create_* arrays and used in saveCreateAtlasToJson()
func getCreateAtlasDict() -> Dictionary:
	var output_dict : Dictionary = {}
	print("Gerando dicionário para salvar (Create Atlas)...")
	
	# Certifica que os arrays estão sincronizados (mesmo tamanho)
	if not (create_ID.size() == create_NAME.size() and create_ID.size() == create_AMOUNT.size() and create_ID.size() == create_ICON.size()):
		push_error("Erro Crítico: Arrays de criação dessincronizados! Abortando a criação do dicionário.")
		print("Tamanhos: ID=%d, NAME=%d, AMOUNT=%d, ICON=%d" % [create_ID.size(), create_NAME.size(), create_AMOUNT.size(), create_ICON.size()])
		return {}
	
	for i in range(create_ID.size()):
		var item_id = create_ID[i]
		var item_name = create_NAME[i]
		var item_amount = create_AMOUNT[i]
		var item_icon = create_ICON[i]
		
		# Usa o ID como chave STRING no JSON
		var id_str = str(item_id)
		
		# Verifica se ID já existe (não deveria acontecer com IDs baseados em índice)
		if output_dict.has(id_str):
			push_warning("ID duplicado encontrado durante a criação do dicionário: '%s'. Sobrescrevendo item anterior." % id_str)
		
		output_dict[id_str] = {
			"NAME": item_name,
			"AMOUNT": item_amount,
			# "STACK_SIZE": 64, # Adicionar se necessário, talvez pegar de outro LineEdit?
			"ICON": item_icon if item_icon != null else ""
		}
	
	print("Dicionário gerado: ", output_dict)
	return output_dict


## Get all the data from create_* arrays (updated via UI) and save them on a json in a selected folder
## On create new item atlas
func saveCreateAtlasToJson(path: String) -> void:
	print("Tentando salvar o novo atlas em: ", path)
	
	# grants that the arrays were previously updateded (its redundant if called, but is safe)
	#_update_create_arrays_from_ui() # Comentado pois deve ser chamado ANTES de _on_create_file_selected
	
	# Gets a dictionary from the UPDATED arrays
	var dict_to_save = getCreateAtlasDict()
	
	# Verifies if there are data to save
	if dict_to_save.is_empty():
		# It can be empty if getCreateAtlasDict fails or doesnt have any itens
		push_error("Dicionário para salvar está vazio. Verifique se há itens ou erros anteriores.")
		# Talvez informar o usuário via UI
		return

	# Converts to .json
	var json_string = JSON.stringify(dict_to_save, "\t", false, true)

	# Opens file for writing
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	if not file:
		push_error("Não foi possível abrir o arquivo para escrita: '%s'. Erro: %s" % [path, error_string(FileAccess.get_open_error())])
		# Informar o usuário via UI
		return
	
	# 6. WRites and closes the file
	file.store_string(json_string)
	file.close()
	print("Novo atlas salvo com sucesso em: ", path)
	
	
	_clear_create_atlas_state() # Clears the state after sucess
	
	# Opcional: Mudar para a aba de visualização/edição do atlas recém-criado?
	# current_json_path = path
	# readJson(path)
	# createLoadSlot()
