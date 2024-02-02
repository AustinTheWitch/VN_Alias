extends Control

#Dictionary Data--------------------------------------------------------------------------------------
var DialogueScript = {
	"Scene1": ["Oii!!!!","Hey!!!", "Is it working?!!!"],
	"Scene2": ["Did it just work?!!!", "Let's Go!!!"],
	"Scene3": ["Did you serioursly figure out?!", "That's awesome but...."],
	"Scene4": ["Oh Wow!!!!", "It genuinely works!!!"],
}

var Narrator = {
	"Scene1": ["Spongebob","Spongebob", "Sayori"],
	"Scene2": ["Sayori", "Sayori"],
	"Scene3": ["Spongebob", "Spongebob"],
	"Scene4": ["Sayori", "Sayori"],
}

var PlayerScript = {
	"Player1": ["Yeah. I think so.","Yes....?","Yup!!!!" , 1, 2, 3],
	"Player2": ["Let's try it one more time", "Can I work on another feature now?", "Possibly...again?", 2, 3, 1],
	"Player3": ["It's working?", "Start from the top....", "Ok...Hmmmm...", 3, 0, 1],
	"Player4": ["How about another test?", "....", "Finally!!!!", 0, 2, 1]
}

var Ch1Select = {
	"Scene1": ["None", "Spongebob", "None"],
	"Scene2": ["Sayori", "Spongebob"],
	"Scene3": ["Spongebob", "Spongebob"],
	"Scene4": ["None", "None"]
}

var Ch2Select = {
	"Scene1": ["None", "Sayori", "Sayori"],
	"Scene2": ["Spongebob", "Sayori"],
	"Scene3": ["None", "None"],
	"Scene4": ["Sayori", "Sayori"],
}

var BackdropSelect = {
	"Scene1": "Moon",
	"Scene2": "City",
	"Scene3": "Moon",
	"Scene4": "Moon"
}


#Galleries Below--------------------------------------------------------------------------------------
var CharacterGallery = {
	"None": null,
	"Spongebob": load("res://Art/Sprites/spongebob.png"),
	"Sayori": load("res://Art/Sprites/Sayori.png")
}
var BackdropGallery = {
	"Moon": load("res://Art/CG/FullMoon.jpg"),
	"City": load("res://Art/CG/City.jpg")
}

#Variables--------------------------------------------------------------------------------------------
var EndLine = false
var SceneKey = 0
var Dialogue = "Testing..."
var LineNum = 0
var Nar = "Speaking..."
var CurrentScene = []
var CurrentNar = []
var MaxLine = 0
var PD1 = Button.new()
var PD2 = Button.new()
var PD3 = Button.new()
var PlayerDecisions = []
var SpriteScript1 = []
var SpriteScript2 = []
var Sprite1 = Texture.new()
var Sprite2 = Texture.new()
var CGselected = Texture.new()
var BackdropChosen = []
var Auto = Button.new()
var AutoSpeed = 3.0
var AutoTime = 0.0
var AutoToggled = false
var Reverse = Button.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	EndLine = false
	_GameSetup()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_SceneSetup()
	_Play()
	$"DialogueBox/DialoguePanel/DialogueText".text = Dialogue
	$Sprite1.texture = Sprite1
	$Sprite2.texture = Sprite2
	$CG.texture = CGselected
	$DialogueBox/DialoguePanel/Narrator.text = Nar
	pass

func _GameSetup():
	CurrentScene = DialogueScript.values()[SceneKey]
	CurrentNar = Narrator.values()[SceneKey]
	PlayerDecisions = PlayerScript.values()[SceneKey]
	SpriteScript1 = Ch1Select.values()[SceneKey]
	SpriteScript2 = Ch2Select.values()[SceneKey]
	BackdropChosen = BackdropSelect.values()
	PD1 = $PlayerInput/Button
	PD2 = $PlayerInput/Button2
	PD3 = $PlayerInput/Button3
	Auto = $PlayerControls/AutoPlay
	Reverse = $PlayerControls/Rewind
	pass

func _SceneSetup():
	$PlayerInput.visible = EndLine
	Dialogue = CurrentScene[LineNum]
	Nar = CurrentNar[LineNum]
	MaxLine = DialogueScript.values()[SceneKey].size() - 1
	PD1.text = PlayerDecisions[0]
	PD2.text = PlayerDecisions[1]
	PD3.text = PlayerDecisions[2]
	SpriteScript1 = Ch1Select.values()[SceneKey]
	Sprite1 = CharacterGallery.get(SpriteScript1[LineNum])
	SpriteScript2 = Ch2Select.values()[SceneKey]
	Sprite2 = CharacterGallery.get(SpriteScript2[LineNum])
	BackdropChosen = BackdropSelect.values()[SceneKey]
	CGselected = BackdropGallery.get(BackdropChosen)

func _SceneSelection():
	LineNum = 0
	CurrentScene = DialogueScript.values()[SceneKey]
	PlayerDecisions = PlayerScript.values()[SceneKey]
	SpriteScript1 = Ch1Select.values()[SceneKey]
	SpriteScript2 = Ch2Select.values()[SceneKey] 
	MaxLine = DialogueScript.values()[SceneKey].size()
	EndLine = false
	AutoToggled = false

func _input(event):
	if event.is_action_released("Progress") and EndLine == false:
		LineNum += 1
	elif LineNum >= MaxLine:
		EndLine = true
		if PD1.button_pressed and EndLine == true:
			SceneKey = PlayerScript.values()[SceneKey][3]
			_SceneSelection()
		elif PD2.button_pressed and EndLine == true:
			SceneKey = PlayerScript.values()[SceneKey][4]
			_SceneSelection()
		elif PD3.button_pressed and EndLine == true:
			SceneKey = PlayerScript.values()[SceneKey][5]
			_SceneSelection()
	else: EndLine = false
		
	if Auto.button_pressed and AutoToggled == false:
		AutoToggled = true
	elif Auto.button_pressed and AutoToggled == true:
		AutoToggled = false
		
	if Reverse.button_pressed:
		if LineNum <= 0:
			LineNum = 0
		else: LineNum -= 1
		print (LineNum)

func _Play():
	if AutoToggled == true:
		AutoTime += get_process_delta_time() * 1.0
		if AutoTime >= AutoSpeed and EndLine == false:
			LineNum += 1
			AutoTime = 0.0
		elif LineNum >= MaxLine:
			EndLine = true
			AutoToggled = false
			AutoTime = 0.0
	elif AutoToggled == false:
		AutoTime = 0.0

