extends Control

var data #GameData call---------
var sprites #Sprite Script call
var gamescene #Game Scene Script call


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

#Options Menu Vars=-------------------------------------
var Options = false
var MasterVol = 0.0
var AmbianceVol = 0.0
var SoundVol = 0.0
var MusicVol = 0.0

#Pause Menu Vars----------------------------------------
var Paused = false


func _ready():
	data = get_node("/root/GameData")
	gamescene = get_node("/root/GameScene")
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
	_AutoPlay()
	_PlayerDialogue()
	_MenuManager()

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

func _input(event):
	if event.is_action_released("Progress") and EndLine == false and data.Main == false:
		data.LineNum += 1
		gamescene._SoundSelect()
	elif data.LineNum >= MaxLine:
		EndLine = true
	else: EndLine = false
	
	if event.is_action_pressed("Pause") and data.Main == false:
		Paused = !Paused

#Player Dialogue Buttons------------------------------------
func PlayerButton1():
	if pd1.button_pressed and EndLine == true:
		data.LineNum = 0
		data.SceneKey = CurrentPlay[3]
		gamescene._AmbianceSelect()
		gamescene._SoundSelect()
		gamescene._MusicSelect()

func PlayerButton2():
	if pd2.button_pressed and EndLine == true:
		data.LineNum = 0
		data.SceneKey = CurrentPlay[4]
		gamescene._AmbianceSelect()
		gamescene._SoundSelect()
		gamescene._MusicSelect()

func PlayerButton3():
	if pd3.button_pressed and EndLine == true:
		data.LineNum = 0
		data.SceneKey = CurrentPlay[5]
		gamescene._AmbianceSelect()
		gamescene._SoundSelect()
		gamescene._MusicSelect()

#AutoPlay Function-----------------------------------------
func APbutton():
	APtoggled = !APtoggled
func _AutoPlay():
	if APtoggled == true:
		APstart += get_process_delta_time() * 1.0
		if APstart >= APspeed and EndLine == false:
			data.LineNum += 1
			gamescene._SoundSelect()
			APstart = 0.0
		elif data.LineNum >= MaxLine:
			EndLine = true
			APtoggled = false
			APstart = 0.0
	elif APtoggled == false:
		APstart = 0.0

#Rewind Button---------------------------------------------
func Rewind():
	if data.LineNum <= 0:
			data.LineNum = 0
	else: data.LineNum -= 1

func _MenuManager():
	$OptionsPanel.visible = Options
	$MenuPanel.visible = data.Main
	$PausePanel.visible = Paused
	
	if data.Main == true:
		Paused = false
		$PlayerControls.visible = false
		$PlayerInput.visible = false
		$DialogueBox.visible = false
	
	elif Options == true:
		$PlayerControls.visible = false
		$PlayerInput.visible = false
		$DialogueBox.visible = false
	
	elif Paused == true:
		data.Main = false
		$PlayerControls.visible = false
		$PlayerInput.visible = false
		$DialogueBox.visible = false
	else: 
		$PlayerControls.visible = true
		$DialogueBox.visible = true
		if EndLine == true:
			$PlayerInput.visible = true


#Main Menu-------------------------------------------------
func Continue():
	print("Continues Game")

func NewGame():
	data.Main = false
	Options = false
	data.LineNum = 0
	data.SceneKey = 0
	gamescene._AmbianceSelect()
	gamescene._MusicSelect()

func Load():
	print("Loads Game")

func Gallery():
	print("Gallery Viewer")

func Settings():
	Options = !Options

func Exit():
	print("Exit Game")

#Options Menu-----------------------------------------------
func MasterVolume(MasterVol):
	AudioServer.set_bus_volume_db(0, MasterVol)
func AmbianceVolume(AmbianceVol):
	AudioServer.set_bus_volume_db(1, AmbianceVol)
func SoundVolume(SoundVol):
	AudioServer.set_bus_volume_db(2, SoundVol)
func MusicVolume(MusicVol):
	AudioServer.set_bus_volume_db(3, MusicVol)

#Pause Menu--------------------------------------------------
func Resume():
	Paused = !Paused
func Save():
	print("Saves Game")
func MainMenu():
	data.Main = !data.Main
