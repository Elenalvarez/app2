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

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		move_up()
		add_piece()
	if Input.is_action_just_pressed("ui_down"):
		move_down()
		add_piece()
	if Input.is_action_just_pressed("ui_left"):
		move_left()
		add_piece()
	if Input.is_action_just_pressed("ui_right"):
		move_right()
		add_piece()

func _on_touch_control_move(direction: Vector2):
	pass 

func is_blank_space():
	var blank = false
	for i in height:
		for j in width:
			if board[i][j] == 0:
				blank = true
	return blank

func move_up():
	for i in range(1, height):
		for j in width:
			if board[i][j] != 0:
				var container = grid.get_node(get_container_name(i, j))
				var temp = container.get_child(0).duplicate()
				board[i][j] = 0
				for k in i+1:
					var container_name = get_container_name(k,j)
					if board[k][j] != 0:
						var block_to_add:Block = grid.get_node(container_name).get_child(0)
						if block_to_add.get_block_name() == temp.get_block_name():
							match i-k:
								3:
									if board[k+1][j] == 0 and board[k+2][j] == 0:
										block_to_add.add_value(temp.get_value())
										break
								2:
									if board[k+1][j] == 0:
										block_to_add.add_value(temp.get_value())
										break
								1:
									block_to_add.add_value(temp.get_value())
									break
							
					else:
						grid.get_node(container_name).add_child(temp)
						board[k][j]= 1
						break
				container.get_child(0).free()

func move_down():
	for i in range(height-2, -1, -1):
		for j in width:
			if board[i][j] != 0:
				var container = grid.get_node(get_container_name(i, j))
				var temp = container.get_child(0).duplicate()
				board[i][j] = 0
				for k in range(height-1, -1, -1):
					var container_name = get_container_name(k,j)
					if board[k][j] != 0:
						var block_to_add:Block = grid.get_node(container_name).get_child(0)
						if block_to_add.get_block_name() == temp.get_block_name():
							match k-i:
								3:
									if board[i+1][j] == 0 and board[i+2][j] == 0:
										block_to_add.add_value(temp.get_value())
										break
								2:
									if board[i+1][j] == 0:
										block_to_add.add_value(temp.get_value())
										break
								1:
									block_to_add.add_value(temp.get_value())
									break
					else:
						grid.get_node(container_name).add_child(temp)
						board[k][j]= 1
						break
				
				container.get_child(0).free()

func move_left():
	for j in range(1, width):
		for i in height:
			if board[i][j] != 0:
				var container = grid.get_node(get_container_name(i, j))
				var temp = container.get_child(0).duplicate()
				board[i][j] = 0
				for k in j+1:
					var container_name = get_container_name(i,k)
					if board[i][k] != 0:
						var block_to_add:Block = grid.get_node(container_name).get_child(0)
						if block_to_add.get_block_name() == temp.get_block_name():
							match j-k:
								3:
									if board[i][k+1] == 0 and board[i][k+2] == 0:
										block_to_add.add_value(temp.get_value())
										break
								2:
									if board[i][k+1] == 0:
										block_to_add.add_value(temp.get_value())
										break
								1:
									block_to_add.add_value(temp.get_value())
									break
					else:
						grid.get_node(container_name).add_child(temp)
						board[i][k]= 1
						break
						
				container.get_child(0).free()

func move_right():
	for j in range(width-2, -1, -1):
		for i in height:
			if board[i][j] != 0:
				var container = grid.get_node(get_container_name(i, j))
				var temp = container.get_child(0).duplicate()
				board[i][j] = 0
				for k in range(width-1, -1, -1):
					var container_name = get_container_name(i,k)
					if board[i][k] != 0:
						var block_to_add:Block = grid.get_node(container_name).get_child(0)
						if block_to_add.get_block_name() == temp.get_block_name():
							match k-j:
								3:
									if board[i][j+1] == 0 and board[i][j+2] == 0:
										block_to_add.add_value(temp.get_value())
										break
								2:
									if board[i][j+1] == 0:
										block_to_add.add_value(temp.get_value())
										break
								1:
									block_to_add.add_value(temp.get_value())
									break
					else:
						grid.get_node(container_name).add_child(temp)
						board[i][k]= 1
						break
						
				container.get_child(0).free()

func add_piece():
	if is_blank_space():
		var blocks_mades = 0
		while blocks_mades < 2:
			var row = int(randi_range(0,height-1))
			var column = int(randi_range(0,width-1))
			var type = int(randi_range(0, blocks.size()-1))
			if board[row][column] == 0:
				var temp = blocks[type].instantiate()
				var container_name = get_container_name(row, column)
				grid.get_node(container_name).add_child(temp)
				board[row][column] = 1
				blocks_mades += 1
	else:
		print("No space")

func get_container_name(row: int, column: int):
	var number= 4*row + column+1
	var name = "CenterContainer" + str(number)
	return name



