extends Control

var data
var mainmenu
var saveload
var setting

var paused = false

func _ready():
	data = get_node("/root/GameData")
	mainmenu = get_node("/root/MainMenu")
	saveload = get_node("/root/SaveLoadMenu")
	setting = get_node("/root/SettingMenu")

func _process(delta):
	$PausePanel.visible = paused
	if paused == false and mainmenu.main == false and setting.setting == true:
		setting.setting = false
	else: return

func _resume():
	pass

func _savegame():
	saveload.saving = true

func _loadgame():
	saveload.loading = true

func _gallery():
	pass

func _settings():
	setting.setting = !setting.setting

func _mainmenu():
	mainmenu.main = true
	paused = false
	setting.setting = false
