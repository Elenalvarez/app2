extends Node2D

@onready var settings: TextEdit = $Settings
@onready var character: TextEdit = $Character
@onready var shop: TextEdit = $Shop


func _on_settings_button_pressed():
	settings.visible = true
	character.visible = false
	shop.visible = false

func _on_character_button_pressed():
	settings.visible = false
	character.visible = true
	shop.visible = false

func _on_shop_button_pressed():
	settings.visible = false
	character.visible = false
	shop.visible = true
