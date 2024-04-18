extends CharacterBody2D
class_name Character

@onready var stats: Stats = get_node("Stats")

func get_hp():
	return stats.hp

func get_max_hp():
	return stats.max_hp

func get_my_name():
	return stats.my_name
