extends Control

var data #Game Data call
var options #Setting Menu call
var loader #Loading Menu call
var scene #Game Scene call
var gallery #Gallery call

var main = true
var play = false

func _ready():
	data = get_node("/root/GameData")
	options = get_node("/root/SettingMenu")
	loader = get_node("/root/SaveLoadMenu")
	scene = get_node("/root/GameScene")
	gallery = get_node("/root/Gallery")
	play = false
	main = true

func _process(_delta):
	$MenuPanel.visible = main

func _newgame():
	data.LineNum = 0
	data.SceneKey = 0
	scene._ambianceselect()
	scene._musicselect()
	main = false
	options.setting = false
	play = true
	loader.loading = false
	gallery.gallery = false
	gallery.fullscreen = false
	print ("Put Confirm Screen In Here")

func _loadgame():
	loader.loading = true
	gallery.gallery = false
	gallery.fullscreen = false

func _gallery():
	gallery.gallery = !gallery.gallery
	options.setting = false

func _settings():
	options.setting = true
	gallery.gallery = false
	gallery.fullscreen = false

func _exitgame():
	print("Confirm Quit Window First")
