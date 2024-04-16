extends Node2D

var height: int = 4
var width: int = 4
var board: Array = [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]]

var blocks = [preload("res://scenes/blocks/damage_block.tscn"),
preload("res://scenes/blocks/defend_block.tscn"),
preload("res://scenes/blocks/heal_block.tscn")]

@onready var grid = $GridContainer


func _ready():
	add_piece()


func _on_touch_control_move(direction: Vector2):
	move_blocks(direction) 

func is_blank_space():
	var blank = false
	for i in height:
		for j in width:
			if board[i][j] == 0:
				blank = true
	return blank

func move_blocks(direction: Vector2):
	match direction:
		Vector2.UP:
			pass
		Vector2.DOWN:
			pass
		Vector2.RIGHT:
			pass
		Vector2.LEFT:
			pass

func add_piece():
	if is_blank_space():
		var blocks_mades = 0
		while blocks_mades < 2:
			var row = int(randi_range(0,height-1))
			var column = int(randi_range(0,width-1))
			var type = int(randi_range(0, blocks.size()-1))
			if board[row][column] == 0:
				var temp = blocks[type].instantiate()
				var container_name = get_container_number(row, column)
				grid.get_node(container_name).add_child(temp)
				board[row][column] = 1
				blocks_mades += 1
	else:
		print("No space")

func get_container_number(row: int, column: int):
	var number= 4*row + column+1
	var name = "CenterContainer" + str(number)
	return name



