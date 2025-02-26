extends Node

var _orders: Dictionary = {
	'move': _move	
}

func _ready() -> void:
	Signals.connect(Signals.str_char_order, order)


func order(order_received: String, args) -> void:
	if order_received in _orders.keys():
		_orders[order_received].call(args)
	else:
		push_error('ORDER %s NOT FOUND' % order_received)

func _move(destination: Vector2) -> void:
	pass
	
