extends Control

var data #Game Data call
var setting = false

# volume varables--------------------
var master = 0.0
var ambiance = 0.0
var sound = 0.0
var music = 0.0

func _ready():
	data = get_node("/root/GameData")
	setting = false

func _process(delta):
	$OptionsPanel.visible = setting

func _mastervolume(_Master):
	AudioServer.set_bus_volume_db(0,master)

func _ambiancevolume(_Ambiance):
	AudioServer.set_bus_volume_db(1,ambiance)

func _soundvolume(_Sound):
	AudioServer.set_bus_volume_db(2,sound)

func _musicvolume(_Music):
	AudioServer.set_bus_volume_db(3,music)

func _exitoptions():
	setting = false
