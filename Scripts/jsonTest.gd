extends Node

func _writefunc():
	var data = {
		"File1": [1, 2, "Moon", "Date"], 
		"Scene": 4,
		"Text": "Json!!!!"
	}
	var j_string = JSON.stringify(data)
	print (j_string)
	var file = FileAccess.open("user://json.save", FileAccess.WRITE)
	file.store_string(j_string)

func _readfunc():
	var file = FileAccess.open("user://json.save", FileAccess.READ)
	var jay_string = file.get_as_text()
	var jason = JSON.new()
	var data = JSON.parse_string(jay_string)
	var pulleddata = data.get("File1")
	print(pulleddata[0])

func _ready():
	#_writefunc()
	_readfunc()
