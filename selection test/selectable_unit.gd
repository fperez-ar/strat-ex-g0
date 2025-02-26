extends CharacterBody2D

func _ready():
	add_to_group("units")

func select():
	$SelectionCircle.visible = true

func deselect():
	$SelectionCircle.visible = false
