extends TextureProgressBar
class_name ManaBar

@onready var character: Character

func set_character(name: String):
	character = get_parent().get_node(name)

func update():
	value = character.get_mana() * 100 / character.get_max_mana()
