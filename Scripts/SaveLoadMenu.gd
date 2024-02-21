extends Control

var data # Game Data call
var scene # Game Scene call
var pausemenu # Pause Menu call
var mainmenu # Main Menu call

var saving = false
var loading = false
# Timestamp varables-------------------------------
var savetime = [] # string varable
var teststring = "def"
# Image varables-----------------------------------
var saveimage = []
var imagestring = ["Test"]
var savekey = [1]

func _ready():
	data = get_node("/root/GameData")
	scene = get_node("/root/GameScene")
	pausemenu = get_node("/root/PauseMenu")
	mainmenu = get_node("/root/MainMenu")
	savetime = get_tree().get_nodes_in_group("SaveText")
	saveimage = get_tree().get_nodes_in_group("SaveImage")

func _process(delta):
	$Background.visible = saving or loading
	if saving == true:
		loading = false
	elif loading == true:
		saving = false

func _savegame():
	saving = false
	pausemenu.paused = false
	mainmenu.main = false
	mainmenu.play = true

func _loadgame():
	scene._ambianceselect()
	scene._musicselect()
	loading = false
	pausemenu.paused = false
	mainmenu.main = false
	mainmenu.play = true 

func _file1():
	if saving == true:
		_savegame()
	else: _loadgame()

func _exitsaveload():
	saving = false
	loading = false
