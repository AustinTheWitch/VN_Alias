extends Control

var data #Game Data call
var setting = false

# volume varables--------------------
var master = 0.0
var masterslider = HSlider.new()
var ambiance = 0.0
var ambianceslider = HSlider.new()
var sound = 0.0
var soundslider = HSlider.new()
var music = 0.0
var musicslider = HSlider.new()

# saved varables----------------------
var mastervolume = 0
var ambiancevolume = 0
var soundvolume = 0
var musicvolume = 0

func _ready():
	masterslider = $OptionsPanel/ScrollParent/SettingScroll/MasterVol/MasterSlider
	ambianceslider = $OptionsPanel/ScrollParent/SettingScroll/AmbianceVol/AmbianceSlider
	soundslider = $OptionsPanel/ScrollParent/SettingScroll/SoundVol/SoundSlider
	musicslider = $OptionsPanel/ScrollParent/SettingScroll/MusicVol/MusicSlider
	_loadsettings()
	data = get_node("/root/GameData")
	setting = false

func _process(_delta):
	$OptionsPanel.visible = setting

func _loadsettings():
	if FileAccess.file_exists("user://settings.save"):
		print("File Found")
		var file = FileAccess.open("user://settings.save", FileAccess.READ)
		mastervolume = file.get_var()
		masterslider.value = mastervolume
		ambiancevolume = file.get_var()
		ambianceslider.value = ambiancevolume
		soundvolume = file.get_var()
		soundslider.value = soundvolume
		musicvolume = file.get_var()
		musicslider.value = musicvolume
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
