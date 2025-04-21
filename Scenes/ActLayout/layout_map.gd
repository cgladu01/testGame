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
		
func _on_level_changed():
	visible = false

func reveal():
	Global.currentRoom.bfsShowAll()

func _on_toggle_map():
	visible = not visible
	get_node("../Control").visible = not visible
