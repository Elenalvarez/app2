extends Control

@onready var settings = $Settings
@onready var character = $Character
@onready var shop = $Shop
@onready var music = $AudioStreamPlayer2D
@onready var money = $Money/Label_money

@onready var hp_number = $Character/VBoxContainer/HBoxContainer/HP_number
@onready var mana_number = $Character/VBoxContainer/HBoxContainer2/Mana_number
@onready var damage_number = $Character/VBoxContainer/HBoxContainer3/Damage_number
@onready var defense_number = $Character/VBoxContainer/HBoxContainer4/Defense_number
@onready var heal_number = $Character/VBoxContainer/HBoxContainer5/Heal_number
@onready var movements_number = $Character/VBoxContainer/HBoxContainer6/Movements_number

@onready var dont_money_message = $Shop/DontMoneyMessage

func _process(delta):
	money.text = str(Arsen.get_my_money())

func _on_settings_button_pressed():
	settings.visible = true
	character.visible = false
	shop.visible = false

func _on_character_button_pressed():
	settings.visible = false
	character.visible = true
	shop.visible = false
	updateCharacter()

func _on_shop_button_pressed():
	settings.visible = false
	character.visible = false
	shop.visible = true

func _on_exit_settings_pressed():
	settings.visible= false

func _on_music_button_pressed():
	AudioPlayer.pause_music()

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

func updateUI():
	settings.get_node("TextEdit").text = tr("SETTINGS")
	settings.get_node("MusicButton").text = tr("MUSIC")
	settings.get_node("Label").text = tr("LANGUAGE")
	
	character.get_node("TextEdit").text = tr("CHARACTER")
	character.get_node("VBoxContainer/HBoxContainer/HP").text = tr("HP")
	character.get_node("VBoxContainer/HBoxContainer2/Mana").text = tr("MANA")
	character.get_node("VBoxContainer/HBoxContainer3/Damage").text = tr("DAMAGE")
	character.get_node("VBoxContainer/HBoxContainer4/Defense").text = tr("DEFENSE")
	character.get_node("VBoxContainer/HBoxContainer5/Heal").text = tr("HEAL")
	character.get_node("VBoxContainer/HBoxContainer6/Movements").text = tr("MOVEMENTS")
	
	shop.get_node("TextEdit").text = tr("SHOP")
	shop.get_node("VBoxContainer/HBoxContainer/Sword").text = tr("SWORD")
	shop.get_node("VBoxContainer/HBoxContainer2/Armor").text = tr("ARMOR")
	shop.get_node("VBoxContainer/HBoxContainer3/Book").text = tr("BOOK")
	shop.get_node("VBoxContainer/HBoxContainer4/Necklace").text = tr("NECKLACE")
	shop.get_node("VBoxContainer/HBoxContainer5/Boots").text = tr("BOOTS")
	shop.get_node("DontMoneyMessage").text = tr("MESSAGE")

func updateCharacter():
	hp_number.text = str(Arsen.get_max_hp())
	mana_number.text = str(Arsen.get_max_mana())
	damage_number.text = str(Arsen.get_damage())
	defense_number.text = str(Arsen.get_defense())
	heal_number.text = str(Arsen.get_heal())
	movements_number.text = str(Arsen.get_movements())

func _on_exit_character_pressed():
	character.visible= false

func _on_exit_shop_pressed():
	shop.visible=  false

func _on_button_sword_pressed():
	var cost = 50
	if Arsen.get_my_money() > cost:
		purchase()
	else:
		dont_money_message.visible = true
		await get_tree().create_timer(1).timeout
		dont_money_message.visible = false

func _on_button_armor_pressed():
	var cost = 50
	if Arsen.get_my_money() > cost:
		purchase()
	else:
		dont_money_message.visible = true
		await get_tree().create_timer(1).timeout
		dont_money_message.visible = false

func _on_button_book_pressed():
	var cost = 50
	if Arsen.get_my_money() > cost:
		purchase()
	else:
		dont_money_message.visible = true
		await get_tree().create_timer(1).timeout
		dont_money_message.visible = false

func _on_button_necklace_pressed():
	var cost = 100
	if Arsen.get_my_money() > cost:
		purchase()
	else:
		dont_money_message.visible = true
		await get_tree().create_timer(1).timeout
		dont_money_message.visible = false

func _on_button_boots_pressed():
	var cost = 200
	if Arsen.get_my_money() > cost:
		purchase()
	else:
		dont_money_message.visible = true
		await get_tree().create_timer(1).timeout
		dont_money_message.visible = false

func purchase():
	pass
