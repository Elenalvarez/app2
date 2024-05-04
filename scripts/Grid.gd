extends Node2D

#variables para la grid
var height: int = 4
var width: int = 4
var board: Array = [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]]

#variables para el swipe
var startPos: Vector2
var curPos: Vector2
var swiping = false

var blocks = [preload("res://scenes/blocks/damage_block.tscn"),
preload("res://scenes/blocks/defend_block.tscn"),
preload("res://scenes/blocks/heal_block.tscn")]

@onready var grid = $GridContainer
@onready var level: level = get_parent()
@onready var animation = $AnimationPlayer
@onready var area = get_node("Area2D")


func _ready():
	set_process_input(true)
	add_piece(2)

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		move_up()
		await get_tree().create_timer(0.2).timeout
		add_piece(1)
		level.make_movement()
	if Input.is_action_just_pressed("ui_down"):
		move_down()
		await get_tree().create_timer(0.2).timeout
		add_piece(1)
		level.make_movement()
	if Input.is_action_just_pressed("ui_left"):
		move_left()
		await get_tree().create_timer(0.2).timeout
		add_piece(1)
		level.make_movement()
	if Input.is_action_just_pressed("ui_right"):
		move_right()
		await get_tree().create_timer(0.2).timeout
		add_piece(1)
		level.make_movement()

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		if !swiping:
			swiping = true
			startPos = get_global_mouse_position()
			print(str(startPos))
	
	if event is InputEventScreenTouch and !event.pressed:
		if swiping:
			curPos= get_global_mouse_position()
			if startPos.distance_to(curPos) >= 100:
				if abs(startPos.y - curPos.y) <= 75:
					if startPos.x > curPos.x:
						print("<-")
						move_left()
						add_piece(1)
						level.make_movement()
					else:
						print("->")
						move_right()
						add_piece(1)
						level.make_movement()
				elif abs(startPos.x - curPos.x) <= 75:
					if startPos.y > curPos.y:
						print("^")
						move_up()
						add_piece(1)
						level.make_movement()
					else:
						print("v")
						move_down()
						add_piece(1)
						level.make_movement()
			swiping = false

func is_blank_space():
	var blank = false
	for i in height:
		for j in width:
			if board[i][j] == 0:
				blank = true
	return blank

func move_up():
	animation.play("up")
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
	animation.play("down")
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
	animation.play("left")
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
	animation.play("right")
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

func add_piece(num_pieces: int):
	if is_blank_space():
		var blocks_mades = 0
		while blocks_mades < num_pieces:
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

func get_max_block():
	var val_max = 0
	var blocks: Array
	var coord: Array
	var result_block
	var result_coords
	var result_container
	
	for i in height:
		for j in width:
			if board[i][j] != 0:
				var container = grid.get_node(get_container_name(i, j))
				var temp = container.get_child(0).duplicate()
				if temp.get_value() == val_max:
					blocks.push_back(temp)
					coord.push_back([i, j])
				if temp.get_value() > val_max:
					val_max = temp.get_value()
					blocks.clear()
					coord.clear()
					blocks.push_back(temp)
					coord.push_back([i, j])
	
	if blocks.size() > 1:
		var ind = int(randi_range(0, blocks.size()-1))
		result_block = blocks[ind]
		result_coords = coord[ind]
		result_container = grid.get_node(get_container_name(result_coords[0], result_coords[1]))
	else:
		result_block = blocks[0]
		result_coords = coord[0]
		result_container = grid.get_node(get_container_name(result_coords[0], result_coords[1]))
	
	if result_block.get_block_name() == "DamageBlock":
		level.attack_turn(result_block.get_value())
	if result_block.get_block_name() == "DefendBlock":
		level.defend_turn(result_block.get_value())
	if result_block.get_block_name() == "HealBlock":
		level.heal_turn(result_block.get_value())
	
	board[result_coords[0]][result_coords[1]] = 0
	result_container.get_child(0).free()


