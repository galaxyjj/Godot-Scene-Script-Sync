@tool
extends EditorPlugin


func _enter_tree() -> void:
	var selection := EditorInterface.get_selection()
	selection.selection_changed.connect(_on_selection_changed)


func _exit_tree() -> void:
	var selection := EditorInterface.get_selection()
	if selection.selection_changed.is_connected(_on_selection_changed):
		selection.selection_changed.disconnect(_on_selection_changed)


func _on_selection_changed() -> void:
	var root := EditorInterface.get_edited_scene_root()
	if root == null or root.script == null:
		return

	var script_editor := EditorInterface.get_script_editor()
	if script_editor.get_current_script() == root.script:
		return

	EditorInterface.edit_resource(root.script)
