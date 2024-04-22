extends Node
class_name Stats

signal hp_changed(new_hp)
signal hp_depleted()

const MANA_INCREASE = 10

@export var starting_stats: Resource

var my_name: String
var hp: int
var mana: int
var max_hp: int
var max_mana: int
var damage: int 
var defense: int
var heal: int
var movement: int

func _ready():
	my_name = starting_stats.my_name
	max_hp = starting_stats.max_hp
	max_mana = starting_stats.max_mana
	damage = starting_stats.damage
	defense = starting_stats.defense
	heal = starting_stats.heal
	movement = starting_stats.movement
	hp = max_hp
	mana = 0

func set_max_hp(value: int):
	max_hp = max(0, value)

func set_max_mana(value: int):
	max_mana = max(0, value)

func increase_mana(mult: int):
	mana += mult * MANA_INCREASE

func make_damage(mult_attack: int):
	return damage * mult_attack

func take_damage(hit: int, mult_defense: int):
	var def = defense * mult_defense
	var dam = hit - def
	hp = max(0, hp - dam)
	emit_signal("hp_changed", hp)
	if hp == 0:
		emit_signal("hp_depleted")

func healing(mult_heal: int):
	hp = max(max_hp, hp + heal * mult_heal)
	emit_signal("hp_changed", hp)




