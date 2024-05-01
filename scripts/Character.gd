extends CharacterBody2D
class_name Character

@onready var stats: Stats = get_node("Stats")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

var inventory: Array

func get_my_name():
	return stats.my_name
	
func get_hp():
	return stats.hp

func get_max_hp():
	return stats.max_hp

func get_mana():
	return stats.mana

func get_max_mana():
	return stats.max_mana

func get_damage():
	return stats.damage

func get_defense():
	return stats.defense

func get_heal():
	return stats.heal

func get_my_money():
	return stats.money

func get_movements():
	return stats.movement

func set_max_hp(value: int):
	stats.set_max_hp(value)

func set_max_mana(value: int):
	stats.set_max_mana(value)

func set_damage(value: int):
	stats.set_damage(value)

func set_defense(value: int):
	stats.set_defense(value)

func set_heal(value: int):
	stats.set_heal(value)

func set_movements(value: int):
	stats.set_movements(value)

func increase_mana(mult: int):
	stats.increase_mana(mult)

func increase_money(cant: int):
	stats.increase_money(cant)

func decrease_money(cant: int):
	stats.decrease_money(cant)

func make_damage(mult_attack: int):
	match mult_attack:
		1, 2, 3: 
			animated_sprite.play("attack_1")
		4, 5, 6:
			animated_sprite.play("attack_2")
		7, 8, 9:
			animated_sprite.play("attack_3")
		10:
			animated_sprite.play("attack_ultimate")
			stats.mana = 0
	return stats.make_damage(mult_attack)

func take_damage(hit: int, mult_defense: int):
	if mult_defense == 0:
		animated_sprite.play("take_hit")
	else:
		animated_sprite.play("defense")
	stats.take_damage(hit, mult_defense)
	if is_dead():
		animated_sprite.play("death")

func healing(mult_heal: int):
	stats.healing(mult_heal)

func is_dead():
	return stats.hp == 0
