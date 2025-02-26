extends Node

#var str_char_ready: String = 'char_ready'
#signal char_ready(id: int, node: Node)

var str_char_clicked: String = 'char_clicked'
signal char_clicked(order: String)

var str_char_order: String = 'char_order'
signal char_order(id: int, order: String, args)
