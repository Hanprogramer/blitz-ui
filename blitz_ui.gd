@tool
extends EditorPlugin

var script_button = preload("res://addons/blitz_ui/controls/button.gd")
var script_anim_state = preload("res://addons/blitz_ui/animations/blitz_anim_state.gd")
var script_state = preload("res://addons/blitz_ui/animations/blitz_states.gd")


func _enter_tree():
	add_custom_type("BlitzButton", "BaseButton", script_button, null)
	add_custom_type("BlitzAnimationState", "Resource", script_anim_state, null)
	add_custom_type("BlitzStates", "Resource", script_state, null)
	# ThemeDB.get_project_theme().add_type("BlitzButton")


func _exit_tree():
	remove_custom_type("BlitzButton")
