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
var lastsave = []

func _ready():
	data = get_node("/root/GameData")
	scene = get_node("/root/GameScene")
	pausemenu = get_node("/root/PauseMenu")
	mainmenu = get_node("/root/MainMenu")
	savetime = get_tree().get_nodes_in_group("SaveText")
	saveimage = get_tree().get_nodes_in_group("SaveImage")

func _process(_delta):
	$Background.visible = saving or loading
	if saving == true:
		loading = false
	elif loading == true:
		saving = false
	_filelabel()

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
	if loadedfile != null:
		data.SceneKey = loadedfile[0]
		data.LineNum = loadedfile[1]
		scene._ambianceselect()
		scene._musicselect()
		_loadset()
	else: print("No File")

func _filelabel():
	var file = FileAccess.open("user://gamefile.save", FileAccess.READ)
	var loadstring = file.get_as_text()
	filedata = JSON.parse_string(loadstring)
	
	#File Arrays--------------------------------------
	var file1 = []
	var file2 = []
	var file3 = []
	var file4 = []
	
	file1 = filedata.get("File1")
	if file1 != null:
		saveimage[0].set_texture_normal(data.BackdropGallery.get(file1[2]))
		savetime[0].text = file1[3]
	else: pass
	
	file2 = filedata.get("File2")
	if file2 != null:
		saveimage[1].set_texture_normal(data.BackdropGallery.get(file2[2]))
		savetime[1].text = file2[3]
	else: pass

	file3 = filedata.get("File3")
	if file3 != null:
		saveimage[2].set_texture_normal(data.BackdropGallery.get(file3[2]))
		savetime[2].text = file3[3]
	else: pass

	file4 = filedata.get("File4")
	if file4 != null:
		saveimage[3].set_texture_normal(data.BackdropGallery.get(file4[2]))
		savetime[3].text = file4[3]
	else: pass

func _file1():
	filename = "File1"
	if saving == true:
		_savegame()
	else: _loadgame()

func _file2():
	filename = "File2"
	if saving == true:
		_savegame()
	else: _loadgame()

func _file3():
	filename = "File3"
	if saving == true:
		_savegame()
	else: _loadgame()

func _file4():
	filename = "File4"
	if saving == true:
		_savegame()
	else: _loadgame()

func _exitsaveload():
	saving = false
	loading = false
