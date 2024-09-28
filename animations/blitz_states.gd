@tool
extends Resource
class_name BlitzStates

enum State { Normal, Hover, Pressed, Focus }

@export var states: Array[BlitzAnimationState]
@export var default_state: BlitzAnimationState


# Gets an animation for specific state
func get_state_animation_for(state: State) -> BlitzAnimationState:
	for i in states:
		if i == null:
			continue
		if i.state == state:
			return i
	return default_state


# Play an animation for a state
func play(target: Control, state: State) -> void:
	if target == null: return
	if target.is_inside_tree() == false: return
	var state_anim = get_state_animation_for(state)
	if state_anim != null:
		state_anim.play(target)


# Returns true if any of the states is playing their animation
func is_playing() -> bool:
	var playing = false
	for i in states:
		if i == null:
			continue
		playing = playing or i.is_playing()
	return playing or default_state.is_playing()
