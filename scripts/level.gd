extends Node2D
class_name level

const ARSEN = preload("res://scenes/characters/Arsen.tscn")

@onready var arsen_position = get_node("ArsenMarker")
@onready var enemy_position = get_node("EnemyMarker")
@onready var arsen_health_bar: HealthBar = get_node("ArsenHealthBar")
@onready var enemy_health_bar: HealthBar = get_node("EnemyHealthBar")

@export var enemy_type: PackedScene

func _ready():
	var pj = ARSEN.instantiate()
	pj.position = arsen_position.position
	add_child(pj)
	arsen_health_bar.set_character(pj.get_my_name())
	arsen_health_bar.update()
	
	var enemy = enemy_type.instantiate()
	enemy.position = enemy_position.position
	add_child(enemy)
	enemy_health_bar.set_character(enemy.get_my_name())
	enemy_health_bar.update()
	

func _process(delta):
	pass
