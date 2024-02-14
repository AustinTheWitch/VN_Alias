extends Control
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

var OneSelect = {
	"Scene1": ["None", "Spongebob", "None"],
	"Scene2": ["Black Widow", "Spongebob"],
	"Scene3": ["Spongebob", "Spongebob"],
	"Scene4": ["None", "None"]
}

var TwoSelect = {
	"Scene1": ["None", "Yoda", "Black Widow"],
	"Scene2": ["Spongebob", "Black Widow"],
	"Scene3": ["None", "None"],
	"Scene4": ["Black Widow", "Black Widow"],
}

var ThreeSelect = {
	"Scene1": ["None", "None", "Yoda"],
	"Scene2": ["None", "Yoda"],
	"Scene3": ["None", "None"],
	"Scene4": ["None", "None"],
}

var CGscript = {
	"Scene1": "Moon",
	"Scene2": "City",
	"Scene3": "Moon",
	"Scene4": "Moon"
}

var AmbianceScript = {
	"Scene1": "Rain",
	"Scene2": "Crowded Room",
	"Scene3": "Rain",
	"Scene4": "Rain",
}

var SoundScript = {
	"Scene1": ["None", "Sword", "None"],
	"Scene2": ["Sword", "None"],
	"Scene3": ["Sword", "Sword"],
	"Scene4": ["None", "None"]
}

var MusicScript = {
	"Scene1": "FairyTail",
	"Scene2": "Relax",
	"Scene3": "FairyTail",
	"Scene4": "None",
	}

#Galleries Below--------------------------------------------------------------------------------------
var CharacterGallery = {
	"None": null,
	"Spongebob": load("res://Art/Sprites/spongebob.png"),
	"Black Widow": load("res://Art/Sprites/BlackWidow.png"),
	"Yoda": load("res://Art/Sprites/Yoda.png")
}
var BackdropGallery = {
	"Moon": load("res://Art/CG/FullMoon.jpg"),
	"City": load("res://Art/CG/City.jpg")
}

var AmbianceGallery = {
	"Rain": load("res://Audio/Ambiance/Rain.mp3"),
	"Crowded Room": load("res://Audio/Ambiance/CrowdedRoom.mp3")
}

var SoundGallery = {
	"Sword": load("res://Audio/Sound/SwordSlash.mp3"),
	"None": null
}

var MusicGallery = {
	"FairyTail": load("res://Audio/Music/FairyTale.mp3"),
	"Relax": load("res://Audio/Music/Relax.mp3"),
	"None": null
}

var SceneKey = 0
var LineNum = 0

var mastervol = 0.0
var ambiancevol = 0.0
var soundvol = 0.0
var musicvol = 0.0
