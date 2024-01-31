extends Resource

var _DialogueScript = {
	"Scene1": ["Hey!!!!","Hey!!!", "Is it working?!!!"],
	"Scene2": ["Did it just work?!!!", "Let's Go!!!"],
	"Scene3": ["Did you serioursly figure out?!", "That's awesome but...."],
	"Scene4": ["Oh Wow!!!! It genuinely works!!!"],
	}
var Narartor = "Who?"
var DialogueLine = 0



func _Data():
	var gamedata = [1, 2, 3, 4]
	var json_string = JSON.stringify(gamedata)
	
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		var data_recieved = json.data
		if typeof(data_recieved) == TYPE_ARRAY:
			print(data_recieved)
		else:
			print("Unexpected Data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
