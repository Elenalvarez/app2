extends Node2D

var L1 = load("res://scenes/levels/level1.tscn")
var L2 = load("res://scenes/levels/level2.tscn")
var L3 = load("res://scenes/levels/level3.tscn")
var L4 = load("res://scenes/levels/level4.tscn")

func _ready():
	AudioPlayer.play_music_general()

func _on_button_pressed():
	get_tree().change_scene_to_packed(L1)

func _on_button_l_2_pressed():
	get_tree().change_scene_to_packed(L2)

func _on_button_l_3_pressed():
	get_tree().change_scene_to_packed(L3)

func _on_button_l_4_pressed():
	get_tree().change_scene_to_packed(L4)
