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
@onready var arsen_health_number = get_node("ArsenHealthBar/TextEdit")
@onready var enemy_health_number = get_node("EnemyHealthBar/TextEdit")

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
	arsen_health_number.text = str(pj.get_hp())
	
	var e = enemy_type.instantiate()
	e.position = enemy_position.position
	add_child(e)
	enemy = get_node(e.get_my_name())
	enemy_health_bar.set_character(e.get_my_name())
	enemy_health_bar.update()
	enemy_health_number.text = str(e.get_hp())

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
	var mult_normal = mult
	#ataca arsen primero, comprobando si tiene ulti
	if arsen.get_mana() == arsen.get_max_mana():
		mult= 10
	
	enemy.take_damage(arsen.make_damage(mult), 1)
	enemy_health_bar.update()
	arsen_mana_bar.update()
	enemy_health_number.text = str(enemy.get_hp())
	await arsen.animated_sprite.animation_finished
	await enemy.animated_sprite.animation_finished
	
	#ataca el enemigo
	if not enemy.is_death():
		enemy_attack()
	
	#sube el maná
	increase_mana(mult_normal)

func defend_turn(mult: int):
	#arsen se defiende del ataque enemigo
	arsen.take_damage(enemy.make_damage(1), mult)
	arsen_health_bar.update()
	arsen_health_number.text = str(arsen.get_hp())
	await arsen.animated_sprite.animation_finished
	
	#sube el maná
	increase_mana(mult)

func heal_turn(mult: int):
	#arsen se cura
	arsen.healing(mult)
	arsen_health_bar.update()
	arsen_health_number.text = str(arsen.get_hp())
	
	#ataca el enemigo
	enemy_attack()
	
	#sube el maná
	increase_mana(mult)

func increase_mana(mult: int):
	arsen.increase_mana(mult)
	arsen_mana_bar.update()

func enemy_attack():
	arsen.take_damage(enemy.make_damage(1), 0)
	arsen_health_bar.update()
	arsen_health_number.text = str(arsen.get_hp())
	await arsen.animated_sprite.animation_finished


