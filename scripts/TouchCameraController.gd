extends Camera2D

var touch_points: Dictionary = {}



func _input(event):
	if event is InputEventScreenTouch:
		handle_touch(event)
	elif event is InputEventScreenDrag:
		handle_drag(event) 

func handle_touch(event: InputEventScreenTouch):
	pass

func handle_drag(event: InputEventScreenDrag):
	pass
