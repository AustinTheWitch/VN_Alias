extends Control

var data #Game Data------------------
var main #Main Menu------------------
var pause #Pause Menu----------------

var fullscreen: bool
var gallery: bool
var CGdata = []
var CGimage = TextureRect
var CGnumber = 0

func _ready():
	data = get_node("/root/GameData")
	main = get_node("/root/MainMenu")
	pause = get_node("/root/PauseMenu")
	CGdata = get_tree().get_nodes_in_group("CG")
	CGimage = $CGBox/CGfull
	fullscreen = false
	gallery = false
	_CGlibrary()

func _process(_delta):
	$Panel.visible = gallery
	$CGBox.visible = fullscreen

func _CGlibrary():
	CGdata[0].set_texture_normal(data.BackdropGallery.get("Moon"))
	CGdata[1].set_texture_normal(data.BackdropGallery.get("City"))
	CGimage.texture = CGdata[CGnumber].texture_normal

func _CG1():
	CGnumber = 0
	fullscreen = true
	_CGlibrary()

func _CG2():
	CGnumber = 1
	fullscreen = true
	_CGlibrary()

func _closegallery():
	fullscreen = false
