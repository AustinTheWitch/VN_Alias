extends Control

var data #Game Data call
var setting = false

# volume varables--------------------
var master = 0.0
var ambiance = 0.0
var sound = 0.0
var music = 0.0

# saved varables----------------------
var mastervolume = 0
var ambiancevolume = 0
var soundvolume = 0
var musicvolume = 0

func _ready():
	_loadsettings()
	data = get_node("/root/GameData")
	setting = false

func _process(delta):
	$OptionsPanel.visible = setting

func _loadsettings():
	if FileAccess.file_exists("user://settings.save"):
		print("File Found")
		var file = FileAccess.open("user://settings.save", FileAccess.READ)
		master = file.get_var(mastervolume)
		print (file.get_var(mastervolume))


	else: print("File does not exist")

func _mastervolume(master):
	mastervolume = AudioServer.get_bus_volume_db(0)
	AudioServer.set_bus_volume_db(0, master)

func _ambiancevolume(ambiance):
	ambiancevolume = AudioServer.get_bus_volume_db(1)
	AudioServer.set_bus_volume_db(1, ambiance)

func _soundvolume(sound):
	soundvolume = AudioServer.get_bus_volume_db(2)
	AudioServer.set_bus_volume_db(2, sound)

func _musicvolume(music):
	musicvolume = AudioServer.get_bus_volume_db(3)
	AudioServer.set_bus_volume_db(3, music)

func _savesettings():
	print (mastervolume)
	var file = FileAccess.open("user://settings.save", FileAccess.WRITE)
	file.store_var(mastervolume)
	file.store_var(ambiancevolume)
	file.store_var(soundvolume)
	file.store_var(musicvolume)

func _exitoptions():
	setting = false
	
