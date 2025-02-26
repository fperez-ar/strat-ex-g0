extends Node2D
# node that can be selected 
@export var id: int = -1

func _ready() -> void:
	$Area2D.connect('input_event', handle_input_events)
	id = get_instance_id() if id < 0 else id

func handle_input_events(_viewport:Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Signals.char_clicked.emit(id, self)
			#print('char %s received click' % id)
