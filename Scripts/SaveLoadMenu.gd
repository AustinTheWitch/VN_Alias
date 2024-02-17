extends Control

var data # Game Data call
var scene # Game Scene call
var pausemenu # Pause Menu call
var mainmenu # Main Menu call

var saving = false
var loading = false
var savepath = "user://sceneline.save"


func _ready():
	data = get_node("/root/GameData")
	scene = get_node("/root/GameScene")
	pausemenu = get_node("/root/PauseMenu")
	mainmenu = get_node("/root/MainMenu")

func _process(_delta):
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

func _file1():
	savepath = "user://file1.save"
	if saving == true:
		_savegame()
	else: _loadgame()

func _exitsaveload():
	saving = false
	loading = false
