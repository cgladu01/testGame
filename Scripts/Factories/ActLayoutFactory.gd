class_name  ActLayoutFactory

var rooms : Array[Array] = []
var initial_room : RoomIcon = null
var room_load = preload("res://Scenes/ActLayout/RoomIcon.tscn")
var total_rooms = 0
var combat_rooms = 0
var event_rooms = 0
var elite_rooms = 0
var shop_rooms = 0


func generateLayout(act_number: int):
    # Act 4 will have a special "gaunltet" layout 
    if act_number == 4:
        print("Not made yet")
        pass
    
    var total_rooms: int = 0
    for x in range(0, 20):
        rooms[x] = []
        rooms[x].resize(20)
    initialRoomsSetup()
    

#Makes a plus sign for the inital setup after that it becomes more random.
func initialRoomsSetup():
    makeRoomTypeAt(Vector2i(9, 9), Global.roomType.INITIAL)
    total_rooms += 1

    var current_room = Vector2i(9, 9)
    var basic_room = findAvailable(Vector2i(9,9))
    for available in basic_room:
        if event_rooms <= 0:
            if Global.rng.randi_range(0, 1) == 1:
                makeRoomTypeAt(available, Global.roomType.UNKNOWN)
            else:
                makeRoomTypeAt(available, Global.roomType.COMBAT)
        else:
            makeRoomTypeAt(available, Global.roomType.COMBAT)
        addConnection(current_room, available)
        rooms[available.x][available.y].distance_from_initial = current_room.distance_from_initial + 1
    
    for room in basic_room:
        match  room:
            #Above Starting Room
            Vector2i(9,8):
                makeRoomTypeAt(Vector2i(9,7), generate_random_room(2))
                addConnection(room, Vector2i(9,7))
            #Right of Starting Room
            Vector2i(10,9):
                makeRoomTypeAt(Vector2i(11,9), generate_random_room(2))
                addConnection(room, Vector2i(11,9))
            #Bellow Starting Room
            Vector2i(9,10):
                makeRoomTypeAt(Vector2i(9,11), generate_random_room(2))
                addConnection(room, Vector2i(9,11))
            #Left of Starting Room
            Vector2i(8,9):
                makeRoomTypeAt(Vector2i(7,9), generate_random_room(2))
                addConnection(room, Vector2i(7,9))
    




func findAvailable(location: Vector2i) -> Array[Vector2i]:

    var available : Array[Vector2i]

    for i in range(0, 4):
        match i:
            0:
                if location.x + 1 < 20 and rooms[location.x + 1][location.y] == null:
                    available.append(Vector2i(location.x + 1, location.y))
            1:
                if location.y + 1 < 20 and rooms[location.x][location.y + 1] == null: 
                    available.append(Vector2i(location.x, location.y + 1))
            2:
                if location.x - 1 >= 0 and rooms[location.x - 1][location.y] == null:
                    available.append(Vector2i(location.x - 1, location.y))
            3:
                if location.y - 1 >= 0 and rooms[location.x][location.y - 1] == null:
                    available.append(Vector2i(location.x, location.y - 1))

    return available
       


func makeRoomTypeAt(location : Vector2i, type : Global.roomType):
    rooms[location.x][location.y] = room_load.instantiate()
    match type:
        Global.roomType.INITIAL:
            rooms[location.x][location.y].setup(Global.roomType.INITIAL, null, null)
        Global.roomType.COMBAT:
            combat_rooms += 1
            rooms[location.x][location.y].setup(Global.roomType.COMBAT, null, null)
        Global.roomType.UNKNOWN:
            event_rooms += 1
            rooms[location.x][location.y].setup(Global.roomType.UNKNOWN, null, null)
    
func generate_random_room(distance_from_initial: int)-> Global.roomType:
    if distance_from_initial > 2:
        var possibleRooms = [Global.roomType.ELITE, Global.roomType.COMBAT, Global.roomType.UNKNOWN, Global.roomType.SHOP]
        var rates = [max(3 - elite_rooms, 0), max(10 - combat_rooms, 0), max(6 - event_rooms), max(1 - shop_rooms)]
        return possibleRooms[Global.rng.rand_weighted(rates)]
    else:
        var possibleRooms = [Global.roomType.COMBAT, Global.roomType.UNKNOWN]
        var rates = [max(10 - combat_rooms, 0), max(6 - event_rooms)]
        return possibleRooms[Global.rng.rand_weighted(rates)]
        
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

func addConnection(start : Vector2i, end : Vector2i):
    var diff = start - end
    var diff_abs = diff.abs()
    if diff_abs.x > 2 or diff_abs.y > 2 or diff == Vector2i(1, 1):
        return
    
    match diff:
        Vector2i(-1, 0):
            rooms[start.x][start.y].add_adajacent_room(Global.direction.RIGHT, rooms[end.x][end.y])

        Vector2i(0, -1):
            rooms[start.x][start.y].add_adajacent_room(Global.direction.DOWN, rooms[end.x][end.y])

        Vector2i(1, 0):
            rooms[start.x][start.y].add_adajacent_room(Global.direction.LEFT, rooms[end.x][end.y])
        
        Vector2i(0, 1):
            rooms[start.x][start.y].add_adajacent_room(Global.direction.UP, rooms[end.x][end.y])


