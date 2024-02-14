extends Control

var data # Game Data call

var saving = false
var loading = false
var savepath = "user://sceneline.save"

func _ready():
	pass

func _process(delta):
	$Background.visible = saving or loading

func _savegame():
	pass

func _loadgame():
	pass

func _exitsaveload():
	saving = false
	loading = false
