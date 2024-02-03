extends Control


var game #GameData call---------
var player #player call

#Sprite Vars----------------------------------------
var First = Texture.new()
var FirstScript = []
var Second = Texture.new()
var SecondScript = []
var Third = Texture.new()
var ThirdScript = []

func _ready():
	game = get_node("/root/GameData")

func _process(_delta):
	_SpriteSet()
	pass

func _SpriteSet():
	#Left Side Sprite
	$Left.texture = First
	FirstScript = game.OneSelect.values()[game.SceneKey]
	First = game.CharacterGallery.get(FirstScript[game.LineNum])
	#Right Side Sprite
	$Right.texture = Second
	SecondScript = game.TwoSelect.values()[game.SceneKey]
	Second = game.CharacterGallery.get(SecondScript[game.LineNum])
	#Middle Sprite or Right pushed to Center
	$Mid.texture = Third
	ThirdScript = game.ThreeSelect.values()[game.SceneKey]
	Third = game.CharacterGallery.get(ThirdScript[game.LineNum])
