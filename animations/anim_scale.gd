@tool
class_name ScaleAnimation
extends BlitzAnimation

@export var scale: float = 1.0

var playing = false


func play(target: Control) -> void:
	if target == null or not target.is_inside_tree() or target.is_queued_for_deletion():
		return
	var tree = target.get_tree()
	var tween = target.get_tree().create_tween()
	tween.bind_node(target)
	tween.tween_property(target, "scale", Vector2.ONE * get_value(), duration).set_trans(transition)
	tween.tween_callback(on_finished)
	tween.play()

	playing = true


func on_finished():
	playing = false


func get_value() -> Variant:
	return scale


func is_playing() -> bool:
	return playing
