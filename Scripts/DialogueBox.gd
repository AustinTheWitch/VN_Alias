extends Control

var data #Game Data call
var sprites #Sprite Script call
var gamescene #Game Scene Script call
var decisions #Decision Box call
var mainmenu #Main Menu call
var pausemenu #Pause Menu call

#Input Vars--------------------------------------------
var maxline = 0

#Dialogue Vars-----------------------------------------
var Dialogue = "Testing"
var CurrentScene = []
var Nar = "Talking Here.."
var CurrentNar = []

#AutoPlay Vars------------------------------------------
var AP = Button.new()
var APtimer = Timer.new()
var APspeed = 3.0 #Player adjusted and Essentially a Time Limit
var APstart = false

#Rewind Vars--------------------------------------------
var Reverse = Button.new()

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
	pausemenu = get_node("/root/PauseMenu")
	AP = $PlayerControls/AutoPlay
	Reverse = $PlayerControls/Rewind
	APtimer = $PlayerControls/AutoPlay/Timer

func _process(_delta):
	CurrentScene = data.DialogueScript.values()[data.SceneKey]
	CurrentNar = data.Narrator.values()[data.SceneKey]
	maxline = CurrentScene.size() - 1
	_DialogueBox()
	_MenuManager()

func _DialogueBox():
	Dialogue = CurrentScene[data.LineNum]
	Nar = CurrentNar[data.LineNum]
	$DialogueBox/DialoguePanel/DialogueText.text = Dialogue
	$DialogueBox/DialoguePanel/Narrator.text = Nar

func _input(event):
	if event.is_action_released("Progress") and mainmenu.play == true and data.LineNum < maxline:
		data.LineNum += 1
		gamescene._soundselect()
	
	if event.is_action_pressed("Pause"):
		pausemenu.paused = !pausemenu.paused
		mainmenu.play = !pausemenu.paused

#AutoPlay Functions-----------------------------------------
func _AutoPlay():
	APstart = !APstart
	if APstart == true and data.LineNum < maxline:
		data.LineNum += 1
		APtimer.start(APspeed)
	elif APstart == false or data.LineNum >= maxline:
		APtimer.stop()

func _AutoPlayTimer():
	data.LineNum += 1
	if data.LineNum >= maxline:
		APtimer.stop()

#Rewind Button---------------------------------------------
func Rewind():
	if data.LineNum <= 0:
			data.LineNum = 0
	else: data.LineNum -= 1

func _MenuManager():
	if data.LineNum >= maxline:
		decisions.endline = true
	else: decisions.endline = false
	$DialogueBox.visible = mainmenu.play
	$PlayerControls.visible = mainmenu.play
