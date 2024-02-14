extends Control

var data
var main = true


func _ready():
	data = get_node("/root/GameData")
	pass

func _process(_delta):
	$MenuPanel.visible = main

func _continuegame():
	print("Set Previous Saved Line and Scene")

func _newgame():
	print("Set Line and Scene Key")
	main = false

func _loadgame():
	print("Open Load Menu and make it visible")

func _gallery():
	print("Create and load up gallery")

func _settings():
	print("Open Settings Scene and make it visible")

func _exitgame():
	print("Exit and Close Game")

