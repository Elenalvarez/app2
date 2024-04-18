extends Node
class_name Stats

signal hp_changed(new_hp)
signal hp_depleted()

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

func set_max_hp(value):
	max_hp = max(0, value)

func set_max_mana(value):
	max_mana = max(0, value)

func take_damage(hit: int, mult_defense: int):
	var def = defense * mult_defense
	var dam = hit - def
	hp = max(0, hp-dam)
	emit_signal("hp_changed", hp)
	if hp == 0:
		emit_signal("hp_depleted")

func healing(heal_mult: int):
	hp = max(max_hp, hp + heal*heal_mult)
	emit_signal("hp_changed", hp)




