extends Control

var data # Game Data call
var scene # Game Scene call
var pausemenu # Pause Menu call
var mainmenu # Main Menu call

var saving = false
var loading = false
var savepath = "user://sceneline.save"
# Timestamp varables-------------------------------
var savetime = [] # string varable

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
	
	# _FileData func---------------------------------------------------
	_file1data()

func _process(delta):
	$Background.visible = saving or loading
	if saving == true:
		loading = false
	elif loading == true:
		saving = false

func _savegame():
	var file = FileAccess.open(savepath, FileAccess.WRITE)
	file.store_var(data.SceneKey)
	file.store_var(data.LineNum)
	saving = false
	pausemenu.paused = false
	mainmenu.main = false
	mainmenu.play = true

func _loadgame():
	var file = FileAccess.open(savepath, FileAccess.READ)
	data.SceneKey = file.get_var()
	data.LineNum = file.get_var()
	scene._ambianceselect()
	scene._musicselect()
	loading = false
	pausemenu.paused = false
	mainmenu.main = false
	mainmenu.play = true

# File 1
func _file1data():
	var file = FileAccess.open("user://file1.save", FileAccess.READ)
	savekey[0] = file.get_var()
	imagestring[0] = data.CGscript.values()[savekey[0]]
	saveimage[0].set_texture_normal(data.BackdropGallery.get(imagestring[0]))
func _file1():
	savepath = "user://file1.save"
	if saving == true:
		savekey[0] = data.SceneKey
		imagestring[0] = data.CGscript.values()[savekey[0]]
		saveimage[0].set_texture_normal(data.BackdropGallery.get(imagestring[0]))
		var file = FileAccess.open(savepath, FileAccess.READ)
		file.store_var(savekey[0])
		_savegame()
	else: _loadgame()

func _exitsaveload():
	saving = false
	loading = false
