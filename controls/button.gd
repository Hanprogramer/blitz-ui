@tool
extends Button
class_name BlitzButton

@export var bz_states: BlitzStates

signal hover
signal unhover

var is_hover = false


func _ready():
	keep_pressed_outside = true

	connect("mouse_entered", mouse_entered)
	connect("mouse_exited", mouse_exited)
	connect("button_down", mouse_down)
	connect("button_up", mouse_up)
	connect("resized", on_resized)
	connect("focus_exited", mouse_exited)
	connect("focus_entered", mouse_entered)
	on_resized()


func mouse_entered():
	if bz_states == null:
		return
	bz_states.play(self, BlitzStates.State.Hover)


func mouse_exited():
	if bz_states == null:
		return
	bz_states.play(self, BlitzStates.State.Normal)


func mouse_down():
	if bz_states == null:
		return
	bz_states.play(self, BlitzStates.State.Pressed)


func mouse_up():
	if bz_states == null:
		return
	if is_hovered():
		bz_states.play(self, BlitzStates.State.Hover)
	else:
		bz_states.play(self, BlitzStates.State.Normal)


func on_resized():
	pivot_offset = (size / 2)


func _process(delta):
	if bz_states != null and bz_states.is_playing():
		queue_redraw()
		on_resized()
	var s = is_hovered() or is_pressed()
	if is_hover != s:
		is_hover = s
		if is_hover:
			emit_signal("hover")
		else:
			emit_signal("unhover")

#func _draw():
#var rect = get_rect()
#rect.position = Vector2.ZERO
#var mode = get_draw_mode()
#rect.size /= scale
#
#if mode == DRAW_NORMAL:
#var style = get_theme_stylebox("style_normal", "BlitzButton")
#style.draw(self.get_canvas_item(), rect)
#elif mode == DRAW_HOVER:
#var style = get_theme_stylebox("style_hover", "BlitzButton")
#style.draw(self.get_canvas_item(), rect)
#elif mode == DRAW_PRESSED:
#var style = get_theme_stylebox("style_pressed", "BlitzButton")
#style.draw(self.get_canvas_item(), rect)
#elif mode == DRAW_DISABLED:
#var style = get_theme_stylebox("style_disabled", "BlitzButton")
#style.draw(self.get_canvas_item(), rect)
#elif mode == DRAW_HOVER_PRESSED:
#var style = get_theme_stylebox("style_hover", "BlitzButton")
#style.draw(self.get_canvas_item(), rect)
#var style2 = get_theme_stylebox("style_pressed", "BlitzButton")
#style2.draw(self.get_canvas_item(), rect)
