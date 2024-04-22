extends Node2D
class_name level

const ARSEN = preload("res://scenes/characters/Arsen.tscn")

@onready var grid = get_node("Grid")
@onready var arsen_position = get_node("ArsenMarker")
@onready var enemy_position = get_node("EnemyMarker")
@onready var arsen_health_bar: HealthBar = get_node("ArsenHealthBar")
@onready var arsen_mana_bar: ManaBar = get_node("ArsenManaBar")
@onready var enemy_health_bar: HealthBar = get_node("EnemyHealthBar")
@onready var movement: TextEdit = get_node("Cage_movement/TextEdit")

@export var enemy_type: PackedScene

var max_movs: int
var movs: int
var arsen
var enemy

func _ready():
	var pj = ARSEN.instantiate()
	pj.position = arsen_position.position
	add_child(pj)
	arsen = get_node(pj.get_my_name())
	arsen_health_bar.set_character(pj.get_my_name())
	arsen_health_bar.update()
	arsen_mana_bar.set_character(pj.get_my_name())
	arsen_mana_bar.update()
	max_movs = pj.get_movements()
	movs = max_movs
	movement.text = str(movs)
	
	var e = enemy_type.instantiate()
	e.position = enemy_position.position
	add_child(e)
	enemy = get_node(e.get_my_name())
	enemy_health_bar.set_character(e.get_my_name())
	enemy_health_bar.update()
	

func _process(delta):
	pass

func make_movement():
	movs -= 1
	movement.text = str(movs)
	if movs == 0:
		await get_tree().create_timer(5)
		grid.get_max_block()
		movs = max_movs
		movement.text = str(movs)
	

func attack_turn(mult: int):
	#ataca arsen primero
	enemy.take_damage(arsen.make_damage(mult), 1)
	enemy_health_bar.update()
	
	#ataca el enemigo
	arsen.take_damage(enemy.make_damage(1), 0)
	arsen_health_bar.update()
	
	#sube el maná
	arsen.increase_mana(mult)
	arsen_mana_bar.update()

func defend_turn(mult: int):
	print("Arsen defiende " + str(mult))

func heal_turn(mult: int):
	print("Arsen cura " + str(mult))



