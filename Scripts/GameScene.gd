extends Control

var data #GameData call------------------------------------------------

#CG/Background Vars----------------------------------------------------
var CurrentCG = Texture.new()
var SelectedCG
#Ambiance Vars---------------------------------------------------------
var CurrentOmbie
var SelectedOmbie
#Sound Effect Vars-----------------------------------------------------
var SelectedSound = []
var CurrentSound
#Music Vars------------------------------------------------------------
var SelectedMusic
var CurrentMusic

func _ready():
	data = get_node("/root/GameData")
	
func _process(_delta):
	_sceneselect()

func _sceneselect():
	SelectedCG = data.CGscript.values()[data.SceneKey]
	CurrentCG = data.BackdropGallery.get(SelectedCG)
	$Background.texture = CurrentCG

func _ambianceselect():
	SelectedOmbie = data.AmbianceScript.values()[data.SceneKey]
	CurrentOmbie = data.AmbianceGallery.get(SelectedOmbie)
	$Ambiance.stream = CurrentOmbie
	$Ambiance.play()

func _soundselect():
	SelectedSound = data.SoundScript.values()[data.SceneKey]
	CurrentSound = data.SoundGallery.get(SelectedSound[data.LineNum])
	$Sound.stream = CurrentSound
	$Sound.play()

func _musicselect():
	SelectedMusic = data.MusicScript.values()[data.SceneKey]
	CurrentMusic = data.MusicGallery.get(SelectedMusic)
	$Music.stream = CurrentMusic
	$Music.play()
