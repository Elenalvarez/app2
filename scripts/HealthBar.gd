extends TextureProgressBar
class_name HealthBar

@onready var character: Character

func set_character(name: String):
	character = get_parent().get_node(name)

func set_arsen():
	character = Arsen

func update():
	value = character.get_hp() * 100 / character.get_max_hp()
