extends Node2D
class_name level

var ARSEN = load("res://scenes/characters/Arsen.tscn")
var main =  load("res://scenes/main.tscn")

@onready var grid = get_node("Grid")
@onready var arsen_position = get_node("ArsenMarker")
@onready var enemy_position = get_node("EnemyMarker")
@onready var arsen_health_bar: HealthBar = get_node("ArsenHealthBar")
@onready var arsen_mana_bar: ManaBar = get_node("ArsenManaBar")
@onready var enemy_health_bar: HealthBar = get_node("EnemyHealthBar")
@onready var movement = get_node("Cage_movement/TextEdit")
@onready var arsen_health_number = get_node("ArsenHealthBar/TextEdit")
@onready var enemy_health_number = get_node("EnemyHealthBar/TextEdit")
@onready var victory_tag = get_node("TextureRect/Win")
@onready var defeat_tag = get_node("TextureRect/Lose")

@export var enemy_type: PackedScene

var max_movs: int
var movs: int
var enemy

func _ready():
	victory_tag.text = tr("WIN")
	defeat_tag.text = tr("LOSE")
	
	Arsen.position = arsen_position.position
	Arsen.visible = true
	arsen_health_bar.set_arsen()
	arsen_health_bar.update()
	arsen_mana_bar.set_character()
	arsen_mana_bar.update()
	max_movs = Arsen.get_movements()
	movs = max_movs
	movement.text = str(movs)
	arsen_health_number.text = str(Arsen.get_hp())
	
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
		grid.get_max_block()
		movs = max_movs
		movement.text = str(movs)
	

func attack_turn(mult: int):
	var mult_normal = mult
	#ataca arsen primero, comprobando si tiene ulti
	if Arsen.get_mana() == Arsen.get_max_mana():
		mult= 10
	
	enemy.take_damage(Arsen.make_damage(mult), 1)
	enemy_health_bar.update()
	arsen_mana_bar.update()
	enemy_health_number.text = str(enemy.get_hp())
	await Arsen.animated_sprite.animation_finished
	await enemy.animated_sprite.animation_finished
	
	#ataca el enemigo
	if not enemy.is_dead():
		enemy_attack()
	else:
		victory_tag.visible = true
		Arsen.increase_money(100)
		get_tree().paused = true
		await get_tree().create_timer(3).timeout
		get_tree().paused = false
		Arsen.visible = false
		get_tree().change_scene_to_packed(main)
		
	
	#sube el maná
	increase_mana(mult_normal)

func defend_turn(mult: int):
	#arsen se defiende del ataque enemigo
	Arsen.take_damage(enemy.make_damage(1), mult)
	arsen_health_bar.update()
	arsen_health_number.text = str(Arsen.get_hp())
	await Arsen.animated_sprite.animation_finished
	
	#sube el maná
	increase_mana(mult)

func heal_turn(mult: int):
	#arsen se cura
	Arsen.healing(mult)
	arsen_health_bar.update()
	arsen_health_number.text = str(Arsen.get_hp())
	
	#ataca el enemigo
	enemy_attack()
	
	#sube el maná
	increase_mana(mult)

func increase_mana(mult: int):
	Arsen.increase_mana(mult)
	arsen_mana_bar.update()

func enemy_attack():
	Arsen.take_damage(enemy.make_damage(1), 0)
	arsen_health_bar.update()
	arsen_health_number.text = str(Arsen.get_hp())
	await Arsen.animated_sprite.animation_finished
	if Arsen.is_dead():
		defeat_tag.visible = true
		get_tree().paused = true
		await get_tree().create_timer(3).timeout
		get_tree().paused = false
		Arsen.visible = false
		get_tree().change_scene_to_packed(main)
		

func _on_go_back_button_pressed():
	get_tree().change_scene_to_packed(main)
