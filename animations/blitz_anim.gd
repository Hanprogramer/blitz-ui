extends Resource
class_name BlitzAnimation

@export var duration: float = 1.0
@export var transition: Tween.TransitionType = Tween.TRANS_LINEAR


func play(target: Control) -> void:
	assert(false, "ERROR: You must implement play() for animations")


func get_value() -> Variant:
	assert(false, "ERROR: You must implement get_value() for animations")
	return null


func is_playing() -> bool:
	assert(false, "ERROR: You must implement is_playing() for animations")
	return false
