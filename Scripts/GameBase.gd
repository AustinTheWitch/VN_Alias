extends Control

var data #Game Data call
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
var Play = false

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

# Menu Varables-------------------------------------
var Options = false

# Volume--------------------------------------------
var MasterVol
var AmbianceVol 
var SoundVol
var MusicVol

#Pause Menu Vars----------------------------------------
var Paused = false

#Load/Save Game Vars-----------------------------------------
var Saving = false
var Loading = false
var SaveFile = FileAccess.open("user://myfile.name", FileAccess.READ)
var SavePath = "user://sceneline.save"
var SaveImages = ["Test1", "Test2", "Test3", "Test4", "Test5"]
var FileNum = []


func _ready():
	data = get_node("/root/GameData")
	gamescene = get_node("/root/GameScene")
	EndLine = false
	APtoggled = false
	AP = $PlayerControls/AutoPlay
	Reverse = $PlayerControls/Rewind
	FileNum = get_tree().get_nodes_in_group("Files")

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
		gamescene._soundselect()
	elif data.LineNum >= MaxLine and Play == true:
		EndLine = true
	else: EndLine = false
	
	if event.is_action_pressed("Pause") and data.Main == false:
		Paused = !Paused
		Play = !Paused
		if Options == true and Paused == false:
			Options = false
			Loading = false
			Saving = false
		else: Options = Options


#Player Dialogue Buttons------------------------------------
func PlayerButton1():
	if pd1.button_pressed and EndLine == true:
		data.LineNum = 0
		data.SceneKey = CurrentPlay[3]
		gamescene._ambianceselect()
		gamescene._soundselect()
		gamescene._musicselect()

func PlayerButton2():
	if pd2.button_pressed and EndLine == true:
		data.LineNum = 0
		data.SceneKey = CurrentPlay[4]
		gamescene._ambianceselect()
		gamescene._soundselect()
		gamescene._musicselect()

func PlayerButton3():
	if pd3.button_pressed and EndLine == true:
		data.LineNum = 0
		data.SceneKey = CurrentPlay[5]
		gamescene._ambianceselect()
		gamescene._soundselect()
		gamescene._musicselect()

#AutoPlay Function-----------------------------------------
func APbutton():
	APtoggled = !APtoggled

func _AutoPlay():
	if APtoggled == true:
		APstart += get_process_delta_time() * 1.0
		if APstart >= APspeed and EndLine == false:
			data.LineNum += 1
			gamescene._soundselect()
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
	#$MenuPanel.visible = 
	$PausePanel.visible = Paused
	$DialogueBox.visible = Play
	$PlayerControls.visible = Play
	$SaveLoadWindow.visible = Loading or Saving

#Main Menu-------------------------------------------------
func Continue():
	print("Continues Game")
	Play = true
	data.Main = false
	Options = false
	gamescene._ambianceselect()
	gamescene._musicselect()

func NewGame():
	data.Main = false
	Options = false
	Play = true
	data.LineNum = 0
	data.SceneKey = 0
	gamescene._ambianceselect()
	gamescene._musicselect()
	Loading = false
	Saving = false

func LoadGame():
	Loading = !Loading
	Saving = false
	Play = false
	_SaveImage()


func Gallery():
	print("Gallery Viewer")

func Settings():
	Options = !Options
	Play = false

func Exit():
	print("Exit Game")

#Options Menu-----------------------------------------------
func MasterVolume(_Master):
	AudioServer.set_bus_volume_db(0, MasterVol)

func AmbianceVolume(_Ambiance):
	AudioServer.set_bus_volume_db(1, AmbianceVol)

func SoundVolume(_Sound):
	AudioServer.set_bus_volume_db(2, SoundVol)

func MusicVolume(_Music):
	AudioServer.set_bus_volume_db(3, MusicVol)

#Pause Menu--------------------------------------------------
func Resume():
	Paused = false
	Options = false
	Play = true
	Saving = false
	Loading = false

func SaveGame():
	Saving = !Saving
	Loading = false
	Play = false

func MainMenu():
	data.Main = !data.Main
	Play = false
	Options = false
	Paused = false
	Loading = false
	Saving = false

func _Saving():
	var file = FileAccess.open(SavePath, FileAccess.WRITE)
	file.store_var(data.LineNum)
	file.store_var(data.SceneKey)
	Saving = false
	

func _Loading():
	if FileAccess.file_exists(SavePath):
		print("File Found")
		var file = FileAccess.open(SavePath, FileAccess.READ)
		data.LineNum = file.get_var(data.LineNum)
		data.SceneKey = file.get_var(data.SceneKey)
		gamescene._AmbianceSelect()
		gamescene._MusicSelect()
		Play = true
		data.Main = false
		Paused = false
		Options = false
		Loading = false
	else:
		print("File not found")

#Save Files----------------------------------------------------
func _SaveImage():
	var file1 = FileAccess.open("user://r1f1.save", FileAccess.READ)
	SaveImages[0] = (data.CGscript.values()[file1.get_var(data.SceneKey)])
	FileNum[0].texture = data.BackdropGallery.get(SaveImages[0])
	print(data.CGscript.values()[file1.get_var(data.SceneKey)])

#Row 1 Files---------------------------------------------------
func File1():
	SavePath = "user://r1f1.save"
	print (SavePath)
	if Loading == true and Saving == false:
		_Loading()
	else: _Saving()
func File2():
	SavePath = "user://r1f2.save"
	print(SavePath)
	if (Loading == true and Saving == false):
		_Loading()
	else: _Saving()
func File3():
	SavePath = "user://r1f3.save"
	print(SavePath)
	if (Loading == true and Saving == false):
		_Loading()
	else: _Saving()
func File4():
	SavePath = "user://r1f4.save"
	print(SavePath)
	if (Loading == true and Saving == false):
		_Loading()
	else: _Saving()
#Row 2 Files-------------------------------------------------
func File5():
	SavePath = "user://r2f1.save"
	print(SavePath)
	if (Loading == true and Saving == false):
		_Loading()
	else: _Saving()
func File6():
	SavePath = "user://r2f2.save"
	print(SavePath)
	if (Loading == true and Saving == false):
		_Loading()
	else: _Saving()
func File7():
	SavePath = "user://r2f3.save"
	print(SavePath)
	if (Loading == true and Saving == false):
		_Loading()
	else: _Saving()
func File8():
	SavePath = "user://r2f4.save"
	print(SavePath)
	if (Loading == true and Saving == false):
		_Loading()
	else: _Saving()
#Row 3 Files------------------------------------------------
func File9():
	SavePath = "user://r3f1.save"
	print(SavePath)
	if (Loading == true and Saving == false):
		_Loading()
	else: _Saving()
func File10():
	SavePath = "user://r3f2.save"
	print(SavePath)
	if (Loading == true and Saving == false):
		_Loading()
	else: _Saving()
func File11():
	SavePath = "user://r3f3.save"
	print(SavePath)
	if (Loading == true and Saving == false):
		_Loading()
	else: _Saving()
func File12():
	SavePath = "user://r3f4.save"
	print(SavePath)
	if (Loading == true and Saving == false):
		_Loading()
	else: _Saving()
