class_name Status

var image_path : String = ""
var count : int = 0
var type : int = 0
var name : String = ""

func setup_Status(start_count : int) -> Status:
	count = start_count
	return self

func roundStart():
	pass

func roundEnd():
	pass

func decrementCount():
	count = count - 1

func incrementCount():
	count = count + 1

func deffendEffect(incoming: int, target : Entities, attacker: Entities) -> int:
	return incoming

func attackEffect(incoming: int, attacker: Entities, target: Entities) -> int:
	return incoming