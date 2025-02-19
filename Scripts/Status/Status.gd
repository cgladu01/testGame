class_name Status

var image_path : String = ""
var count : int = 0
var type : int = 0
var name : String = ""
var owner : Entities = null

func setup_Status(start_count : int, new_owner: Entities) -> Status:
	owner = new_owner
	count = start_count
	return self

func roundStart():
	pass

func roundEnd():
	pass

func decrementCount(times: int =1):
	count = count - times

func incrementCount(times : int = 1):
	count = count + times

func deffendEffect(incoming: int, target : Entities, attacker: Entities) -> int:
	return incoming

func attackEffect(incoming: int, attacker: Entities, target: Entities) -> int:
	return incoming