class_name LayoutMap extends CanvasLayer

@onready var container = $"PanelContainer"
var initial_room : RoomIcon = null
var room_load = preload("res://Scenes/ActLayout/RoomIcon.tscn")



func generateMap():
	Global.toggle_map.connect(_on_toggle_map)
	initial_room = room_load.instantiate()
	container.add_child(initial_room)
	initial_room.setup(Global.roomType.INITIAL, null, null)
	Global.currentRoom = initial_room

	var down_room = room_load.instantiate()
	container.add_child(down_room)
	down_room.setup(Global.roomType.UNKNOWN, initial_room)
	down_room.behavior = generate_behavior(Global.roomType.UNKNOWN)

	var down_right_room = room_load.instantiate()
	container.add_child(down_right_room)
	down_right_room.setup(Global.roomType.COMBAT, null, null, null, down_room)
	down_right_room.behavior = generate_behavior(Global.roomType.COMBAT)
	var double_right_room = room_load.instantiate()
	container.add_child(double_right_room)
	double_right_room.setup(Global.roomType.CAMPSITE, null, null, down_right_room, initial_room)

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
	

func _on_toggle_map():
	visible = not visible