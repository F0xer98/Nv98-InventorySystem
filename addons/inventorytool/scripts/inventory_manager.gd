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
@onready var slot_template: MarginContainer = $"create atlas/CreateScrollContainer/scrollVbox/slotTemplate"
@onready var v_box_container: VBoxContainer = $"create atlas/CreateScrollContainer/scrollVbox/slotTemplate/VBoxContainer"
@onready var main_item_holder: HBoxContainer = $"create atlas/CreateScrollContainer/scrollVbox/slotTemplate/VBoxContainer/mainItemHolder"
@onready var add_icon_to_json: Button = $"create atlas/CreateScrollContainer/scrollVbox/slotTemplate/VBoxContainer/mainItemHolder/addIconToJson"
@onready var add_id_to_json: LineEdit = $"create atlas/CreateScrollContainer/scrollVbox/slotTemplate/VBoxContainer/mainItemHolder/addIDToJson"
@onready var add_name_to_json: LineEdit = $"create atlas/CreateScrollContainer/scrollVbox/slotTemplate/VBoxContainer/mainItemHolder/addNameToJson"
@onready var line_edit_2: LineEdit = $"create atlas/CreateScrollContainer/scrollVbox/slotTemplate/VBoxContainer/mainItemHolder/LineEdit2"
@onready var create_file_dialog: FileDialog = $"create atlas/CreateScrollContainer/scrollVbox/slotTemplate/VBoxContainer/mainItemHolder/createFileDialog"

# --- CURRENT ATLAS VISUALIZER ---
@onready var current_atlas_visualizer: VBoxContainer = $"create atlas/current atlas visualizer"
@onready var c_slotmaster_template: MarginContainer = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE"
@onready var c_panel_slot: PanelContainer = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT"
@onready var c_icon_hbox: HBoxContainer = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX"
@onready var c_icon: TextureRect = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX/C_ICON"
@onready var c_id_margin: MarginContainer = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX/C_ID_MARGIN"
@onready var c_item_id: Label = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX/C_ID_MARGIN/C_ITEM_ID"
@onready var c_name_margin: MarginContainer = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX/C_NAME_MARGIN"
@onready var c_item_name: Label = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX/C_NAME_MARGIN/C_ITEM_NAME"
@onready var c_max_stack_margin: MarginContainer = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX/C_MAX_STACK_MARGIN"
@onready var c_max_stack: Label = $"create atlas/current atlas visualizer/C_SLOTMASTER_TEMPLATE/C_PANEL_SLOT/C_ICON_HBOX/C_MAX_STACK_MARGIN/C_MAX_STACK"



# --- ATLAS LOADER ---
@onready var atlas_loader: VBoxContainer = $"read atlas/atlas loader"
@onready var load_button: Button = $"read atlas/atlas loader/LoadButton"
@onready var file_dialog: FileDialog = $"read atlas/atlas loader/FileDialog"
@onready var r_slot_master: MarginContainer = $"read atlas/atlas loader/R_slotMaster"
@onready var r_panel_container: PanelContainer = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer"
@onready var r_slot: HBoxContainer = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot"
@onready var r_texture_rect: TextureRect = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_TextureRect"
@onready var r_margin_container: MarginContainer = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer"
@onready var r_item_id: Label = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer/R_ITEM_ID"
@onready var r_margin_container_2: MarginContainer = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer2"
@onready var r_item_name: Label = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer2/R_ITEM_NAME"
@onready var r_margin_container_3: MarginContainer = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer3"
@onready var r_item_amount: Label = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_MarginContainer3/R_ITEM_AMOUNT"
@onready var r_properties_editor: Button = $"read atlas/atlas loader/R_slotMaster/R_PanelContainer/R_slot/R_PROPERTIES_EDITOR"


# --- CURRENT ATLAS LOADED ---
@onready var current_atlas: VBoxContainer = $"read atlas/current atlas"
@onready var r_scroll_container: ScrollContainer = $"read atlas/current atlas/R_ScrollContainer"
@onready var r_grid_container: GridContainer = $"read atlas/current atlas/R_ScrollContainer/R_GridContainer"

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
var current_json_path: String = "" #holds the path to selected .json file
var create_json_path: String = "" # hold the path to a new atlas

#arrays usados PARA EDIÇÃO DE ATLAS
var ID : Array[int] = [] #somente int
var NAME : Array[String] = [] #somente strings
var ICON : Array = [] #somente ícones
var AMOUNT: Array = []


# arrays usados PARA CRIAÇÃO DE NOVO ATLAS
var create_ID : Array[int] = [] #somente int
var create_NAME : Array[String] = [] #somente strings
var create_ICON : Array = [] #somente ícones
var create_AMOUNT: Array = []

# used in both createNewAtlas and _on_new_slot_created
var current_slots : Array = []
var selected_slot = null


func _ready() -> void:
	load_button.pressed.connect(_on_load_btn_pressed)
	file_dialog.file_selected.connect(_on_selected_file)
	create_button.pressed.connect(createNewAtlas)
	
	# Hides UI as default
	r_slot_master.visible = false
	write_atlas.visible = false
	create_scroll_container.visible = false
	create_h_box_container.visible = false


# --- DEDICATED ARE TO MODIFY AN EXISTING .JSON ---



## Literalmente uma função responsável por criar um atlas do zero.
## Tem integração com a UI
func createNewAtlas() -> void: # Cria um novo slot no .json do atlas
	
	# Altera a visibilidade da área de criação
	create_h_box_container.visible = not create_h_box_container.visible # os botões de criar / deletar slot
	create_scroll_container.visible = not create_scroll_container.visible # para modo de edição
	
	# Só entra no modo edição se a janela estiver aberta para evitar problemas
	if create_scroll_container.visible:
		print("Modo criação de atlas")
		
		# Limpa arrays de criação de items para novo atlas
		create_ID.clear()
		create_NAME.clear()
		create_ICON.clear()
		create_AMOUNT.clear()
		
		# Cria um item inicial vazio nos arrays de edição
		create_ID.append(0)
		create_NAME.append("NOVO ITEM")
		create_AMOUNT.append("0")
		create_ICON.append("")
		
		# caminho para a pasta onde o .json será salvo
		create_json_path = "" #Somente para iniciar. Será definido ao salvar
		
		# Preenche campos da UI do current atlas visualizer com valores de teste
		
		
	# sai do modo edição
	else:
		print("Criação de atlas desativado")

## Creates an UI of the current .json 
func createLoadSlot() -> void:
	print("createLoadSlot")
	
	# Reads itens in .json file
	var items = readJson(current_json_path)
	
	# --- ERROR CHECKING ---
	
	# Checks if current path is valid
	if current_json_path.is_empty():
		push_error("Nenhum arquivo JSON selecionado")
		return
		
	# Grants there is anything inside that .json to process
	if items.is_empty():
		push_error("JSON VAZIO OU INVÁLIDO")
		return
	
	# Clears previous slots to avoid bugs
	for child in r_grid_container.get_children():
		if child != r_slot_master: # Do not remove the original template
			child.queue_free()
	
	# Creates a new "R_slotMaster" for EACH item present in the .json
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
				
		# conecta o sinal do botão de edição passando ID como parâmetro (int)
		edit_btn.pressed.connect(_on_edit_properties.bind(int(id)))

## Reads the json selected by the "Load item atlas" button
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

## Escreve no arquivo .json selecionado
func writeJson():
	
	# --- ERROR CHECKING ---
	if current_json_path.is_empty():
		push_error("Nenhum arquivo JSON selecionado")
		return
	
	if ID.is_empty():
		push_error("Verifique a chave principal dos itens no JSON, está vazio")
	
	var json_data : Dictionary = {}
	var item_data : Dictionary = {}
	var json_string : String
	
	# Preenche os dados NO ARQUIVO .JSON
	for i in range(ID.size()):
		# Verificação de segurança para índices válidos
		if i >= ID.size():
			push_error("Índice ID fora dos limites do array: ", i)
			continue
		
		# Constrói cada item do inventário
		item_data = {
			"NAME": NAME[i],
			"AMOUNT": int(AMOUNT[i]) if str(AMOUNT[i]).is_valid_int() else 0, #AMOUNT = i as int if not valid AMOUNT = 0
			"ICON": ICON[i] if ICON[i] != null else ""
		}
		
		# Adiciona ao dicionário principal
		json_data[str(ID[i])] = item_data
	
	# Converte para JSON formatado
	if not json_data.is_empty():
		json_string = JSON.stringify(json_data, "\t", false, true)
	else:
		push_error("Dados do JSON estão vazios")
		return
	
	
	# Escreve no arquivo .json selecionado
	var file : FileAccess = FileAccess.open(current_json_path, FileAccess.WRITE)
	if not file:
		push_error("Falha ao abrir arquivo para escrita: ", FileAccess.get_open_error())
		return
	
	file.store_string(json_string)
	file.close()
	
	print("Atlas salvo com sucesso em: ", current_json_path)
	print("Total de itens salvos: ", json_data.size())

## When selected a .json file, calls readJson() to handle that information
## Then calls createNewSlot() to effectively create a new slot
func _on_selected_file(path: String) -> void:
	current_json_path = path # a variável global de caminho do .json recebe o caminho apontado pelo FileDialog
	readJson(path)
	createLoadSlot()


## É chamado ao clicar em "Load item atlas" chama a tela de carregamento e filtra por apenas .json
func _on_load_btn_pressed() -> void:
	
	file_dialog.popup_centered()
	file_dialog.filters = ["*.json"]  # filters only .json

## When clicked on the "change icon" on load item atlas
func _on_edit_icon() -> void:
	
	print("Mudar de ícone") # --- DEBUG ---

## Triggered when pressed ApplyChangesBtn
## Takes the current create_ID, create_AMOUNT, create_ICON and create_NAME and saves it to the .json
## On the path selected by the user (not sure if its setted in the code somewhere, im too tired to check it)
## Just here commenting things 
func _on_apply_changes(item_id: int) -> void:
	print("Aplicando mudanças para o item ID: ", item_id)
	write_atlas.visible = false
	
	# --- ALTERAÇÃO ---
	var index = ID.find(item_id)
	
	# --- ERROR VERIFICATION ---
	if index < 0:
		push_error("ID não encontrado nos arrays internos ao aplicar mudanças: ", item_id)
		return
	
	# --- UPDATES ARRAYS WITH NEW VALUES ---
	NAME[index] = w_change_item_name.text
	AMOUNT[index] = int(w_change_amount.text)
	
	# --- SE TIVER MUDANÇA DE TEXTURA, ELA JÁ ESTÁ ATUALIZADA NO ARRAY ICON DURANTE O _ON_CHANGE_ICON
	
	# alteraço visual do slot
	for slot in r_grid_container.get_children():
		if slot == r_slot_master:
			continue
		
		var slot_id_text = slot.get_node("R_PanelContainer/R_slot/R_MarginContainer/R_ITEM_ID")
		
		#Atualiza os textos no slot com verificação de nodes
		if slot_id_text.text == str(item_id):
			slot.get_node("R_PanelContainer/R_slot/R_MarginContainer2/R_ITEM_NAME").text = NAME[index]
			slot.get_node("R_PanelContainer/R_slot/R_MarginContainer3/R_ITEM_AMOUNT").text = str(AMOUNT[index])
			break
		
		
		# salva alterações no .json
		writeJson()
		
		write_atlas.visible = false
		print("Alterado as informações com sucesso para o item ID: ", item_id)
		
		break
	
	writeJson()

## When clicked on edit properties of a button in the load item atlas
func _on_edit_properties(item_id: int) -> void:

	write_atlas.visible = true
	
	# --- ERROR CHECKING ---
	var index = ID.find(item_id) # recebe int
	print("Current index: ", index)
	
	# Para índices inválidos
	if index < 0:
		push_error("ID não encontrado: ", item_id)
		return
	
	# Para json vazios
	if current_json_path.is_empty():
		push_error("Nenhum arquivo JSON selecionado")
		return
	
	# ###### BEGIN OF TEST PART #######
	
	# Carrega os dados do JSON
	var items_dictionary = readJson(current_json_path) # recebe o dictionary do .json inteiro
	
	
	# FOR ERROR CHECKING
	var item_found: bool = false
	var item_key = null
	
	# Tentativa 1 : Busca DIRETA por string, exatamente como está no json
	if items_dictionary.has(str(item_id)):
		item_key = str(item_id)
		item_found = true
	
	# Tentativa 2 : Buscar pelo int (caso o json não tenha sido convertido)
	elif items_dictionary.has(item_id):
		item_key = item_id
		item_found = true
	
	# Tentativa 3: Busca EM TODAS AS CHAVES (case sensetive e os caralhos)
	
	else:
		for key in items_dictionary.keys():
			if str(key).to_int() == item_id:
				item_key = key
				item_found = true
				break
		if not item_found:
			push_error("Item ID não encontrado no JSON após tentativas, o erro está em outro lugar, ", item_id)
			print("IDs disponíveis no JSON: ", items_dictionary.keys())
			print("Tipos das chaves: ", items_dictionary.keys().map(func(k): return typeof(k)))
	
	# If no error is reported, then it works :)
	
	var item_data = items_dictionary[item_key] #mantém como string pois as chaves do json são strings
	
	# ###### END OF TEST PART ######
	
	#encontrar o slot correspondente ao item_id
	for slot in r_grid_container.get_children():
		if slot == r_slot_master:
			continue
		
		var slot_id_text = slot.get_node("R_PanelContainer/R_slot/R_MarginContainer/R_ITEM_ID").text
		
		if int(slot_id_text) == item_id:
			current_slot_texture = slot.get_node("R_PanelContainer/R_slot/R_TextureRect")
			break
	
	
	# --- PREENCHE OS CAMPOS DE EDIÇÃO ---

	item_in_atlas_name.text = "Editando: " + item_data.get("NAME", "Sem Nome")
	w_change_item_name.text = item_data.get("NAME", "")
	w_change_amount.text = str(item_data.get("AMOUNT", 0))
	
	# --- CONEXÃO DOS BOTÕES ---
	
	# Botão de confirmar mudanças
	if w_confirm_btn.pressed.is_connected(_on_apply_changes):
		w_confirm_btn.pressed.disconnect(_on_apply_changes)
		w_confirm_btn.pressed.connect(_on_apply_changes.bind(item_id))
	
	# Botão de mudar ícone
	if w_change_icon.pressed.is_connected(_on_edit_icon):
		w_change_icon.pressed.disconnect(_on_edit_icon)
	w_change_icon.pressed.connect(_on_edit_icon.bind(item_id))



# --- DEDICATED ARE TO NEW .JSON FROM SCRATCH USING THE PLUGIN ---



## Cria um slot no ARRAY create_ID, create_NAME, create_AMOUNT, e create_ICON
## Porém NÃO é salvo de imediato no .json, fica salvo temporariamente na memória.
## Somente após salvar, que é escrito no .json e pode ser usado como um atlas propriamente dito
## Lembrando que somente o .json é editável.
## O primeiro item tem ID 1
func createAtlasSlot() -> Dictionary:
	print("Criando novo slot")
	
	# Habilita o botão de aplicar e mostra a àrea de criação
	apply_changes_btn.disabled = false
	create_scroll_container.visible = true
	
	# Duplica a instância do slotTemplate e adiciona a ui
	var new_slot = slot_template.duplicate()
	new_slot.visible = true
	new_slot.name = "Slot_%d" % current_slots.size() # seta o nome do node para "Slot + quantos slots tem"
	scroll_vbox.add_child(new_slot)
	current_slots.append(new_slot)
	
	# Calcula um ID único
	var new_id = create_ID.size() # 0, 1, 2, 3, (...)
	
	create_ID.append(new_id)
	create_NAME.append("NOVO ITEM")
	create_AMOUNT.append(0)
	create_ICON.append("") # string vazia = sem ícone definido, usa o placeholder como padrão
	
	# Atualiza o visualizador com os dados do novo slot criado
	
	current_atlas_visualizer.visible = true
	c_item_id.text = str(new_id)
	c_item_name.text = create_NAME.back()
	c_max_stack.text = str(create_AMOUNT.back())
	c_icon.texture = load("res://addons/inventorytool/icons/placeHolder.png") #usa o placeholder como padrão
	
	
	#print a quantidade de IDs a serem criados
	print("create_ID: ", create_ID)
	return getCreateAtlasDict()

## Deleta o Slot no ARRAY create_ID, create_NAME, create_AMOUNT, e create_ICON e também na UI
## Porém NÃO é salvo de imediato no .json, fica salvo temporariamente na memória (array)
func deleteAtlasSlot() -> void:
	
	# Se não tiver slot novo, desativa o botão de salvar e não faz nada
	if current_slots.size() == 0:
		print("Nenhum slot para apagar")
		return
	
	# Pega o último slot que foi adicionado
	var last_slot = current_slots.pop_back()
	
	# Remove ele da cena, seja qual for o parent
	var parent = last_slot.get_parent()
	if parent:
		parent.remove_child(last_slot)
	
	# libera o nó da cena
	last_slot.queue_free()

	# Sincroniza os arrays de dados de criação
	if create_ID.size() > 0:
		create_ID.pop_back()
		create_NAME.pop_back()
		create_ICON.pop_back()
		create_AMOUNT.pop_back()
	print("Slot apagado. Restam %d slots." % current_slots.size())
	
	if current_slots.size() == 0:
		apply_changes_btn.disabled = true
	
	print(create_ID)

func _on_create_file_selected(path: String) -> void:
	# guarda o caminho para futuras salvamentos
	create_json_path = path
	
	print("O arquivo será salvo em: ", path)
	
	# serializar e gravar o JSON
	saveCreateAtlasToJson(create_json_path)
	
## Função específica para criar e salvar um novo json
func _on_new_apply_changes() -> void:
	if create_json_path == "":
		create_file_dialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
		create_file_dialog.access = FileDialog.ACCESS_RESOURCES
		create_file_dialog.filters = ["*.json"]
		create_file_dialog.dialog_hide_on_ok = true
		
		create_file_dialog.file_selected.connect(_on_create_file_selected)
		
		create_file_dialog.popup_centered()
	else:
		saveCreateAtlasToJson(create_json_path)

## Responsável por atualizar o current atlas visualizer
## Quando o usuário selecionar, no slotTemplate do scrollContainer, o equivalente no current atlas visualizer
## Muda de cor para o usuário ter uma confirmação Visual do que ele tá mexendo
## Por exemplo, mudar a cor para vermelho o "C_ITEM_ID" caso o usuário esteja alterando o "addIDToJson"
func _on_hover_new_atlas_creator() -> void:
	# por fazer ainda, só um placeholder por enquanto
	pass

# --- AINDA NÃO INTEGRADO ---

## Gera um dictionary pronto para JSON a partir dos arrays de criação
func getCreateAtlasDict() -> Dictionary:
	var outPut : Dictionary = {}
	
	for i in range(create_ID.size()):
		var id_str = str(create_ID[i])
		outPut[id_str] = {
			"NAME": create_NAME[i],
			"AMOUNT": create_AMOUNT[i],
			"STACK_SIZE": 64,            # ou outro valor padrão ou variável
			"ICON": create_ICON[i]
		}
	
	return outPut

## Pega as informações dos create_ arrays e os salva num JSON na pasta selecionada
func saveCreateAtlasToJson(path: String) -> void:
	var dict = getCreateAtlasDict()
	var json = JSON.stringify(dict, "\t", false, true)
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	if not file:
		push_error("Não conseguiu abrir ", path)
		return
	
	file.store_string(json)
	file.close()
	print("Salvo em JSON na pasta: ", path)
