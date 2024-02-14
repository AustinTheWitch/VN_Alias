extends Control

var data #Game Data call
var sprites #Sprite Script call
var gamescene #Game Scene Script call
var decisions #Decision Box call
var mainmenu #Main Menu call

#Input Vars--------------------------------------------
var maxline = 0

#Dialogue Vars-----------------------------------------
var Dialogue = "Testing"
var CurrentScene = []
var Nar = "Talking Here.."
var CurrentNar = []
var play = false

#AutoPlay Vars------------------------------------------
var AP = Button.new()
var APspeed = 3.0 #Player adjusted and Essentially a Time Limit

#Rewind Vars--------------------------------------------
var Reverse = Button.new()

#Menu Vars----------------------------------------------
var Paused = false

#Load/Save Game Vars-----------------------------------------
var Saving = false
var Loading = false
var SavePath = "user://sceneline.save"
var FileNum = []


func _ready():
	data = get_node("/root/GameData")
	gamescene = get_node("/root/GameScene")
	decisions = get_node("/root/DecisionBox")
	mainmenu = get_node("/root/MainMenu")
	AP = $PlayerControls/AutoPlay
	Reverse = $PlayerControls/Rewind

func _process(_delta):
	maxline = CurrentScene.size() - 1
	CurrentScene = data.DialogueScript.values()[data.SceneKey]
	CurrentNar = data.Narrator.values()[data.SceneKey]
	_DialogueBox()
	_AutoPlay()
	_MenuManager()

func _DialogueBox():
	Dialogue = CurrentScene[data.LineNum]
	Nar = CurrentNar[data.LineNum]
	$DialogueBox/DialoguePanel/DialogueText.text = Dialogue
	$DialogueBox/DialoguePanel/Narrator.text = Nar

func _input(event):
	if event.is_action_released("Progress") and decisions.endline == false and mainmenu.play == true:
		data.LineNum += 1
		gamescene._soundselect()
	elif data.LineNum >= maxline and play == true:
		decisions.endline = true
	else: decisions.endline = false

#AutoPlay Function-----------------------------------------
func _AutoPlay():
	pass

#Rewind Button---------------------------------------------
func Rewind():
	if data.LineNum <= 0:
			data.LineNum = 0
	else: data.LineNum -= 1

func _MenuManager():
	$PausePanel.visible = Paused
	$DialogueBox.visible = mainmenu.play
	$PlayerControls.visible = mainmenu.play

#Pause Menu--------------------------------------------------
func _saving():
	var file = FileAccess.open(SavePath, FileAccess.WRITE)
	file.store_var(data.LineNum)
	file.store_var(data.SceneKey)
	Saving = false
	

func _loading():
	if FileAccess.file_exists(SavePath):
		print("File Found")
		var file = FileAccess.open(SavePath, FileAccess.READ)
		data.LineNum = file.get_var(data.LineNum)
		data.SceneKey = file.get_var(data.SceneKey)
		gamescene._AmbianceSelect()
		gamescene._MusicSelect()
		Paused = false
		Loading = false
	else:
		print("File not found")

#Row 1 Files---------------------------------------------------
func File1():
	SavePath = "user://r1f1.save"
	print (SavePath)
	if Loading == true and Saving == false:
		_loading()
	else: _saving()
