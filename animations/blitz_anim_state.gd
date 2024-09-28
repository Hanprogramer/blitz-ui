@tool
extends Resource
class_name BlitzAnimationState

@export var state: BlitzStates.State
@export var animations: Array[BlitzAnimation]


func play(ctl: Control):
	if ctl.is_queued_for_deletion(): return
	for a in animations:
		if a == null:
			continue
		a.play(ctl)


# Check if any of their animations is playing
func is_playing() -> bool:
	var playing = false
	for a in animations:
		if a == null:
			continue
		playing = playing or a.is_playing()
	return playing
