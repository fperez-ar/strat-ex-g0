extends Node2D
# script (mostly) courtesy of claude 3.7, works with
# CharacterBody2D (root)
# Sprite2D (unit appearance)
# Area2D named "SelectionArea" with circular CollisionShape2D
# Sprite2D named "SelectionCircle" (set visible=false)

var selected_units: Array = []
var is_dragging = false
var drag_start = Vector2()
var drag_end = Vector2()

func _ready():
	for i in range(10):
		var unit = preload("res://selection test/unit.tscn").instantiate()
		unit.position = Vector2(randi_range(100, 900), randi_range(100, 500))
		add_child(unit)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Start selection
				is_dragging = true
				drag_start = get_global_mouse_position()
			else:
				is_dragging = false
				if drag_start.distance_to(get_global_mouse_position()) > 10:
					# Box selection happened, process only once
					_process_box_selection()
					queue_redraw()
	
	if event is InputEventMouseMotion and is_dragging:
		drag_end = get_global_mouse_position()
		queue_redraw()

func _process_box_selection():
	var rect = _get_selection_rectangle()
	var units = get_tree().get_nodes_in_group("units")
	# potential optimization with parsing only units in viewport
	for unit in units:
		if rect.has_point(unit.position):
			_select(unit)
		else:
			_deselect(unit)

func _select(unit) -> void:
	if not unit in selected_units:
		selected_units.append(unit)
		unit.select()
func _deselect(unit) -> void:
	if unit in selected_units:
		selected_units.erase(unit)
		unit.deselect()

func _deselect_all_units():
	for unit in selected_units:
		unit.deselect()
	selected_units.clear()

func _get_selection_rectangle():
	var top_left = Vector2(min(drag_start.x, drag_end.x), min(drag_start.y, drag_end.y))
	var bottom_right = Vector2(max(drag_start.x, drag_end.x), max(drag_start.y, drag_end.y))
	return Rect2(top_left, bottom_right - top_left)

func _draw():
	if is_dragging:
		draw_rect(_get_selection_rectangle(), Color(0.2, 0.5, 1.0, 0.3))
		draw_rect(_get_selection_rectangle(), Color(0.3, 0.6, 1.0, 0.6), false)
