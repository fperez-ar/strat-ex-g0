extends Node2D
enum INPUT_STATE {
	SELECT,
	MOVE,
	ADD,
	SUBS
}
var input_state: INPUT_STATE = INPUT_STATE.SELECT;
var selected: Array = []
var characters: Dictionary = {}

func _ready() -> void:
	#Signals.connect(Signals.str_char_ready, register_char)
	Signals.connect(Signals.str_char_clicked, on_char_click)
	
func register_char(id: int, node: Node):
	print('registered char %s' % id)
	characters[id] = node

func on_char_click(id: int, node: Node) -> void:
	print('char id ',id,' clicked')
	if id not in characters.keys():
		register_char(id, node)
		
	if input_state == INPUT_STATE.SELECT:
		selected.append(node)
		input_state = INPUT_STATE.MOVE

#func handle_input_events(_viewport:Node, event: InputEvent, shape_idx: int) -> void:
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#print('order?')

@onready var tilemap: TileMap = $TileMap

func _unhandled_input(event: InputEvent):
	# Check for a left mouse button click
	if event is InputEventMouseButton:
		print('unhandled input')
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_RIGHT:
				pass
			if event.button_index == MOUSE_BUTTON_LEFT:
				# Get the mouse position in the global coordinate system
				var mouse_position = get_global_mouse_position()
				# Convert the mouse position to tile coordinates
				var tile_position = tilemap.local_to_map(tilemap.to_local(mouse_position))
				print(tile_position)
				# Check if the tile exists at the clicked position
				if tilemap.get_cell_source_id(0, tile_position) != -1:
					# You can now perform actions based on the clicked tile
					print("Clicked on tile at:", tile_position)
