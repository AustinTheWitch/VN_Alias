extends Control

var data

func _ready():
	data = get_node("/root/GameData")
	$MenuPanel.visible = data.Main
	pass
