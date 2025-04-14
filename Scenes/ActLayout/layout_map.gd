class_name LayoutMap extends CanvasLayer

@onready var container = $"PanelContainer"
var initial_room : RoomIcon = null
var room_load = preload("res://Scenes/ActLayout/RoomIcon.tscn")



func generateMap():
	Global.toggle_map.connect(_on_toggle_map)
	Global.actLaytoutFactory.generateLayout(1)
	Global.actLaytoutFactory.rooms[9][9].bfsAddTo(container)
	Global.currentRoom = Global.actLaytoutFactory.rooms[9][9]
	Global.level_changed.connect(_on_level_changed)



func generate_behavior(behavior_type : Global.roomType = Global.roomType.COMBAT) -> Callable:

	match behavior_type:
		Global.roomType.COMBAT:
			return func():
				Global.level_number = 2
				Global.level_changed.emit()
				Global.combatActive = true
				self.visible = false
		Global.roomType.UNKNOWN:
			return func():
				var event = ReflectionMirror.new()
				event.setup()
				var eventNode : EventNode = load("res://Scenes/UI/Events/EventNode.tscn").instantiate()
				eventNode.event = event
				Global.canvas_layer.add_child(eventNode)
				Global.canvas_layer.move_child(eventNode, -1)
				self.visible = false
		


	return func ():
		print("Hello")
	
func _on_level_changed():
	visible = false

func _on_toggle_map():
	visible = not visible
