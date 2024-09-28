@tool
class_name BlitzTouchscreenButton
extends Control

var touch_index = -1
signal pressed

@export var bz_states: BlitzStates

@onready var sb_normal = get_theme_stylebox("normal","Button")
@onready var sb_hover = get_theme_stylebox("hover","Button")
@onready var sb_pressed = get_theme_stylebox("pressed","Button")

var button_pressed:bool = false
var hovered: bool = false

func set_pressed(value):
	button_pressed = value
	if value == false:
		pressed.emit()
		mouse_up()
	else:
		mouse_down()
	queue_redraw()

func set_pressed_no_signal(value):
	button_pressed = false
	if value == false:
		mouse_up()
	else:
		mouse_down()
	queue_redraw()

func is_hovered() -> bool:
	return hovered

func is_pressed() -> bool:
	return button_pressed

func _ready():
	set_process_unhandled_input(true)
	queue_redraw()
	connect("mouse_entered", mouse_entered)
	connect("mouse_exited", mouse_exited)
	#connect("button_down", mouse_down)
	#connect("button_up", mouse_up)
	connect("resized", on_resized)
	connect("focus_exited", mouse_exited)
	connect("focus_entered", mouse_entered)

func _has_point(point: Vector2) -> bool:
	return Rect2(Vector2.ZERO, size).has_point(point)

func _gui_input(event):
	if event is InputEventScreenTouch:
		if _has_point(event.position):
			if event.is_pressed() and touch_index == -1:
				touch_index = event.index
			elif not event.is_pressed():
				hovered = false
			set_pressed(event.pressed)
			accept_event()
		elif not event.is_pressed() and touch_index == event.index:
			set_pressed_no_signal(false)
			touch_index = -1
			hovered = false
			queue_redraw()

func _draw():
	if button_pressed:
		sb_pressed.draw(self.get_canvas_item(), Rect2(Vector2.ZERO, size))
	elif hovered:
		sb_hover.draw(self.get_canvas_item(), Rect2(Vector2.ZERO, size))
	else:
		sb_normal.draw(self.get_canvas_item(), Rect2(Vector2.ZERO, size))


func mouse_entered():
	if bz_states == null:
		return
	bz_states.play(self, BlitzStates.State.Hover)
	hovered = true


func mouse_exited():
	if bz_states == null:
		return
	bz_states.play(self, BlitzStates.State.Normal)
	hovered = false
	queue_redraw()


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
	if hovered != s:
		hovered = s
		if hovered:
			emit_signal("hover")
		else:
			emit_signal("unhover")
