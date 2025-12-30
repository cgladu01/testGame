class_name Status

var status_attributes : StatusAttributes = null
var count : int = 0
# Buff or not
var type : StatusType = StatusType.BUFF
enum StatusType {
	BUFF,
	DEBUFF
}

var name : String = ""
var owner : Entities = null
var RESOURCE_PATH : String  = "res://Resources/Status/"

func setup_Status(start_count : int, new_owner: Entities) -> Status:
	if status_attributes == null:
		status_attributes = StatusAttributes.new()
	owner = new_owner
	count = start_count
	return self

func _get(property: StringName) -> Variant:
	if property in status_attributes:
		return status_attributes.get(property)
	elif property in self.get_property_list():
		return get(property)
	else:
		return null


func roundStart():
	pass

func roundEnd():
	pass

func decrementCount(times: int =1):
	count = count - times

func incrementCount(times : int = 1):
	count = count + times
