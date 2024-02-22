extends Control

var data # Game Data call
var scene # Game Scene call
var pausemenu # Pause Menu call
var mainmenu # Main Menu call

var saving = false
var loading = false
# Timestamp varables-------------------------------
var savetime = [] # text object varable
# Image varables-----------------------------------
var saveimage = []
# File Save Data varables--------------------------
var fileimage = "TestCG"
var filetime = "00:00:00"
var filename = "File"
var filedata = {
	"Empty": [0, 0, "Image", "Time"]
}

func _ready():
	data = get_node("/root/GameData")
	scene = get_node("/root/GameScene")
	pausemenu = get_node("/root/PauseMenu")
	mainmenu = get_node("/root/MainMenu")
	savetime = get_tree().get_nodes_in_group("SaveText")
	saveimage = get_tree().get_nodes_in_group("SaveImage")
	_filelabel()

func _process(_delta):
	$Background.visible = saving or loading
	if saving == true:
		loading = false
	elif loading == true:
		saving = false

func _saveset():
#UI Settings--------------------
	saving = false
	pausemenu.paused = false
	mainmenu.main = false
	mainmenu.play = true

func _savegame():
	fileimage = scene.SelectedCG
	filetime = Time.get_datetime_string_from_system()
	filedata[filename] = [data.SceneKey, data.LineNum, fileimage, filetime]
	var jstring = JSON.stringify(filedata)
	var file = FileAccess.open("user://gamefile.save", FileAccess.WRITE)
	file.store_string(jstring)
	print(jstring)
	_saveset()
func _loadset():
#UI Settings--------------------
	loading = false
	pausemenu.paused = false
	mainmenu.main = false
	mainmenu.play = true

func _loadgame():
#Load Function------------------
	var file = FileAccess.open("user://gamefile.save", FileAccess.READ)
	var loadstring = file.get_as_text()
	filedata = JSON.parse_string(loadstring)
	var loadedfile = filedata.get(filename)
	data.SceneKey = loadedfile[0]
	data.LineNum = loadedfile[1]
	scene._ambianceselect()
	scene._musicselect()
	_loadset()

func _filelabel():
	pass

func _file1():
	filename = "File1"
	if saving == true:
		_savegame()
	else: _loadgame()

func _exitsaveload():
	saving = false
	loading = false
