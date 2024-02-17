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
	data.LineNum = 0
	data.SceneKey = 0
	scene._ambianceselect()
	scene._musicselect()
	main = false
	options.setting = false
	play = true
	loader.loading = false
	print ("Put Confirm Screen In Here")

func _loadgame():
	loader.loading = true

func _gallery():
	print("Create and load up gallery")

func _settings():
	options.setting = true

func _exitgame():
	print("Confirm Quit Window First")
