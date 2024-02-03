extends Control

var data #GameData call------------------------------------------------


#CG/Background Vars----------------------------------------------------
var CurrentCG = Texture.new()
var SelectedCG
#Ambiance Vars---------------------------------------------------------
var AmbiabceStream = AudioStreamPlayer.new()
var CurrentOmbie = AudioStreamMP3.new()
var SelectedOmbie

func _ready():
	data = get_node("/root/GameData")

	
func _process(_delta):
	_SceneSelect()
	_AmbianceSelect()

func _SceneSelect():
	SelectedCG = data.CGscript.values()[data.SceneKey]
	CurrentCG = data.BackdropGallery.get(SelectedCG)
	$Background.texture = CurrentCG

func _AmbianceSelect():
	SelectedOmbie = data.AmbianceScript.values()[data.SceneKey]
	CurrentOmbie = data.AmbianceGallery.get(SelectedOmbie)
	$Ambiance.stream = CurrentOmbie

