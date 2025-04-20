@tool
extends EditorPlugin

var inv_tab
const INVENTORY_MANAGER = preload("res://addons/inventorytool/ui/inventory_manager.tscn")

func _enter_tree() -> void:
	inv_tab = INVENTORY_MANAGER.instantiate()

	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UL, inv_tab)

func _exit_tree() -> void:
	remove_control_from_docks(inv_tab)
	inv_tab.queue_free()
