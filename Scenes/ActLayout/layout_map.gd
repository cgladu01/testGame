class_name LayoutMap extends CanvasLayer

@onready var container = $"PanelContainer"
var initial_room : RoomIcon = null
var room_load = preload("res://Scenes/ActLayout/RoomIcon.tscn")


func generateMap():
    initial_room = room_load.instantiate()
    container.add_child(initial_room)
    initial_room.setup(Global.roomType.INITIAL, null, null)
    Global.currentRoom = initial_room

    var down_room = room_load.instantiate()
    container.add_child(down_room)
    down_room.setup(Global.roomType.UNKNOWN, initial_room)

    var down_right_room = room_load.instantiate()
    container.add_child(down_right_room)
    down_right_room.setup(Global.roomType.COMBAT, null, null, null, down_room)
    down_right_room.behavior = func():
        Global.level_number = 2
        Global.level_changed.emit()
        Global.combatActive = true
        self.visible = false

    var double_right_room = room_load.instantiate()
    container.add_child(double_right_room)
    double_right_room.setup(Global.roomType.CAMPSITE, null, null, down_right_room, initial_room)



