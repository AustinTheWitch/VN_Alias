extends Control

var data #Game Data call
var scene #Game Screen call

var endline = false
var pd1 = Button.new()
var pd2 = Button.new()
var pd3 = Button.new()
var playerdialogue = []

func _ready():
	pd1 = $PlayerInput/Decision1
	pd2 = $PlayerInput/Decision2
	pd3 = $PlayerInput/Decision3
	data = get_node("/root/GameData")
	scene = get_node("/root/GameScene")

func _process(delta):
	_playerchoices()

func _playerchoices():
	$PlayerInput.visible = endline
	playerdialogue = data.PlayerScript.values()[data.SceneKey]
	pd1.text = playerdialogue[0]
	pd2.text = playerdialogue[1]
	pd3.text = playerdialogue[2]

func _decision1():
	data.LineNum = 0
	data.SceneKey = playerdialogue[3]
	scene._ambianceselect()
	scene._musicselect()

func _decision2():
	data.LineNum = 0
	data.SceneKey = playerdialogue[4]
	scene._ambianceselect()
	scene._musicselect()

func _decision3():
	data.LineNum = 0
	data.SceneKey = playerdialogue[5]
	scene._ambianceselect()
	scene._musicselect()
