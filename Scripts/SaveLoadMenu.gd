extends Control

var data # Game Data call
var scene # Game Scene call

var saving = false
var loading = false
var savepath = "user://sceneline.save"

func _ready():
	data = get_node("/root/GameData")
	scene = get_node("/root/GameScene")

func _process(delta):
	$Background.visible = saving or loading
	if saving == true:
		loading = false
	elif loading == true:
		saving = false

func _fileselect():
	pass

func _savegame():
	var file = FileAccess.open(savepath, FileAccess.WRITE)
	file.store_var(data.LineNum)
	file.store_var(data.SceneKey)
	saving = false

func _loadgame():
	if FileAccess.file_exists(savepath):
		print("File Found")
		var file = FileAccess.open(savepath, FileAccess.READ)
		data.LineNum = file.get_var(data.LineNum)
		data.SceneKey = file.get_var(data.SceneKey)
		scene._ambianceselect()
		scene._musicselect()
	else:
		print("File not found")

func _exitsaveload():
	saving = false
	loading = false
