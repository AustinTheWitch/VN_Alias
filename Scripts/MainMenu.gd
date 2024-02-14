extends Control

var data #Game Data call
var options #Setting Menu call
var loader #Loading Menu call
var scene #Game Scene call

var main = true
var play = false

func _ready():
	data = get_node("/root/GameData")
	options = get_node("/root/SettingMenu")
	loader = get_node("/root/SaveLoadMenu")
	scene = get_node("/root/GameScene")
	
	play = false
	main = true

func _process(delta):
	$MenuPanel.visible = main

func _continuegame():
	print("Set Previous Saved Line and Scene")
	main = false
	options.setting = false

func _newgame():
	main = false
	options.setting = false
	play = true
	scene._ambianceselect()
	scene._musicselect()

func _loadgame():
	loader.loading = true
	print("Open Load Menu and make it visible")

func _gallery():
	print("Create and load up gallery")

func _settings():
	options.setting = true
	print("Open Settings Scene and make it visible")

func _exitgame():
	print("Exit and Close Game")

