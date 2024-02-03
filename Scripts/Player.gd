extends Control

var data #GameData call---------
var sprites #Sprite Script call

#Input Vars--------------------------------------------
var EndLine
var MaxLine = 0

#Dialogue Vars-----------------------------------------
var Dialogue = "Testing"
var CurrentScene = []
var Nar = "Talking Here.."
var CurrentNar = []

#Player Vars--------------------------------------------
var pd1 = Button.new()
var pd2 = Button.new()
var pd3 = Button.new()
var CurrentPlay = []

#AutoPlay Vars------------------------------------------
var AP = Button.new()
var APtoggled = false
var APstart = 0.0
var APspeed = 3.0 #Player adjusted and Essentially a Time Limit

#Rewind Vars--------------------------------------------
var Reverse = Button.new()


func _ready():
	data = get_node("/root/GameData")
	EndLine = false
	APtoggled = false
	AP = $PlayerControls/AutoPlay
	Reverse = $PlayerControls/Rewind

func _process(_delta):
	MaxLine = CurrentScene.size() - 1
	CurrentScene = data.DialogueScript.values()[data.SceneKey]
	CurrentNar = data.Narrator.values()[data.SceneKey]
	CurrentPlay = data.PlayerScript.values()[data.SceneKey]
	_DialogueBox()
	_PlayerDialogue()
	_AutoPlay()

func _DialogueBox():
	Dialogue = CurrentScene[data.LineNum]
	Nar = CurrentNar[data.LineNum]
	$DialogueBox/DialoguePanel/DialogueText.text = Dialogue
	$DialogueBox/DialoguePanel/Narrator.text = Nar

func  _PlayerDialogue():
	$PlayerInput.set_visible(EndLine)
	pd1 = $PlayerInput/Button
	pd2 = $PlayerInput/Button2
	pd3 = $PlayerInput/Button3
	pd1.text = CurrentPlay[0]
	pd2.text = CurrentPlay[1]
	pd3.text = CurrentPlay[2]
	pass

func _AutoPlay():
	if APtoggled == true:
		APstart += get_process_delta_time() * 1.0
		if APstart >= APspeed and EndLine == false:
			data.LineNum += 1
			APstart = 0.0
		elif data.LineNum >= MaxLine:
			EndLine = true
			APtoggled = false
			APstart = 0.0
	elif APtoggled == false:
		APstart = 0.0

func _input(event):
	if event.is_action_released("Progress") and EndLine == false:
		data.LineNum += 1
	elif data.LineNum >= MaxLine:
		EndLine = true
		#Player Dialogue Buttons----------------------------
		if pd1.button_pressed and EndLine == true:
			data.LineNum = 0
			data.SceneKey = CurrentPlay[3]
		elif pd2.button_pressed and EndLine == true:
			data.LineNum = 0
			data.SceneKey = CurrentPlay[4]
		if pd3.button_pressed and EndLine == true:
			data.LineNum = 0
			data.SceneKey = CurrentPlay[5]
	else: EndLine = false
	#AutoPlay Button----------------------------------------
	if AP.button_pressed:
		APtoggled = !APtoggled
	#Rewind Button------------------------------------------
	if Reverse.button_pressed:
		if data.LineNum <= 0:
			data.LineNum = 0
		else: data.LineNum -= 1
	

