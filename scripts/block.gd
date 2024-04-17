extends Node2D
class_name Block

@export var value:int
@export var block_name:String
@onready var mult = get_node("TextEdit")

func _ready():
	mult.text = "x" + str(value)

func _process(delta):
	pass

func get_block_name():
	return block_name

func get_value():
	return value

func add_value(add: int):
	value = min(value+add, 9)
	mult.text = "x" + str(value)
