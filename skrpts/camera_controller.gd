extends Camera2D

var dragging = false
var drag_start_position = Vector2()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_MIDDLE:
		if event.pressed:
			dragging = true
			drag_start_position = get_global_mouse_position()
		else:
			dragging = false
	
	elif event is InputEventMouseMotion and dragging:
		var current_mouse_pos = get_global_mouse_position()
		var movement = drag_start_position - current_mouse_pos
		
		position += movement
