class_name Status

var image_path : String = ""
var count : int = 0
var type : int = 0
var name : String = ""

func setup_Status(start_count : int):
	count = start_count

func roundStart():
	pass

func roundEnd():
	pass

func decrementCount():
	count = count - 1

func incrementCount():
	count = count + 1

func attackEffect(incoming: int, attacker: Entities):
	pass