class_name LayoutMap extends CanvasLayer

@onready var container = $"PanelContainer"
var initial_room : RoomIcon = null
var room_load = preload("res://Scenes/ActLayout/RoomIcon.tscn")


func generateMap():
    initial_room = room_load.instantiate()
    container.add_child(initial_room)
    initial_room.setup(Global.roomType.INITIAL, null, null)
    var room = room_load.instantiate()
    container.add_child(room)
    room.setup(Global.roomType.UNKNOWN, initial_room)
