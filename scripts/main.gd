extends Node2D

var L1 = load("res://scenes/levels/level1.tscn")
var L2 = load("res://scenes/levels/level2.tscn")
var L3 = load("res://scenes/levels/level3.tscn")
var L4 = load("res://scenes/levels/level4.tscn")

@onready var settings = $Settings
@onready var character = $Character
@onready var shop = $Shop
@onready var music = $AudioStreamPlayer2D

func updateUI():
	settings.get_node("TextEdit").text = tr("SETTINGS")
	settings.get_node("MusicButton").text = tr("MUSIC")
	settings.get_node("Label").text = tr("LANGUAGE")
	character.get_node("TextEdit").text = tr("CHARACTER")
	shop.get_node("TextEdit").text = tr("SHOP")

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

func _on_button_pressed():
	get_tree().change_scene_to_packed(L1)

func _on_button_l_2_pressed():
	get_tree().change_scene_to_packed(L2)

func _on_button_l_3_pressed():
	get_tree().change_scene_to_packed(L3)

func _on_button_l_4_pressed():
	get_tree().change_scene_to_packed(L4)

func _on_exit_settings_pressed():
	settings.visible= false

func _on_exit_character_pressed():
	character.visible= false

func _on_exit_shop_pressed():
	shop.visible= false

func _on_music_button_pressed():
	music.playing= !music.playing

func _on_menu_button_item_selected(index):
	match index:
		0:
			TranslationServer.set_locale("en")
			updateUI()
		1:
			TranslationServer.set_locale("es")
			updateUI()
		2:
			TranslationServer.set_locale("fr")
			updateUI()
