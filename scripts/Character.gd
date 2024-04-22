extends CharacterBody2D
class_name Character

@onready var stats: Stats = get_node("Stats")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

func get_hp():
	return stats.hp

func get_mana():
	return stats.mana

func get_max_hp():
	return stats.max_hp

func get_max_mana():
	return stats.max_mana

func get_my_name():
	return stats.my_name

func get_movements():
	return stats.movement

func increase_mana(mult: int):
	stats.increase_mana(mult)

func make_damage(mult_attack: int):
	match mult_attack:
		1, 2, 3: 
			animated_sprite.play("attack_1")
		4, 5, 6:
			animated_sprite.play("attack_2")
		7, 8, 9:
			animated_sprite.play("attack_3")
		
	return stats.make_damage(mult_attack)

func take_damage(hit: int, mult_defense: int):
	stats.take_damage(hit, mult_defense)

func healing(mult_heal: int):
	stats.healing(mult_heal)
