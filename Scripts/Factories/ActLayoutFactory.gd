class_name  ActLayoutFactory

var rooms : Array[Array] = []
var initial_room : RoomIcon = null
var room_load = preload("res://Scenes/ActLayout/RoomIcon.tscn")
var total_rooms = 0
var combat_rooms = 0
var event_rooms = 0
var elite_rooms = 0
var shop_rooms = 0
var boss_rooms = 0

enum pathType {MAINPATH, SUBPATH, SIDEROOM}

func generateLayout(act_number: int):
	# Act 4 will have a special "gaunltet" layout 
	if act_number == 4:
		print("Not made yet")
		pass
	
	var total_rooms: int = 0
	rooms.resize(20)
	for x in range(0, 20):
		rooms[x] = []
		rooms[x].resize(20)
	initialRoomsSetup()
	for room in rooms[9][9].connected_rooms():
		mainPath(room)
	

#Makes a plus sign for the inital setup after that it becomes more random.
func initialRoomsSetup():
	makeRoomTypeAt(Vector2i(9, 9), Global.roomType.INITIAL)
	total_rooms += 1

	var current_room = Vector2i(9, 9)
	var basic_room = findAvailable(Vector2i(9,9))
	basic_room.shuffle()
	var initial_rooms = basic_room.slice(0, 2)
	for initial_room in initial_rooms:
		if event_rooms < 0:
			makeRoomTypeAt(initial_room, Global.roomType.UNKNOWN)
		else:
			makeRoomTypeAt(initial_room, Global.roomType.COMBAT)
		addConnection(current_room, initial_room)
		rooms[initial_room.x][initial_room.y].distance_from_initial = 1
		rooms[initial_room.x][initial_room.y].set_discovered()
	
func mainPath(room : RoomIcon):
	var length = Global.rng.randi_range(5, 7)
	var last_subpath = 0
	var subpath_count = 0
	var last_sideroom = 0
	var sideroom_count = 0

	for x in range(length):
		var available = findAvailable(room.tile_location)
		for potential in range(0, available.size()):
			if potential == available.size():
				break

			if findAvailable(available[potential]).size() < 2:
				available.remove_at(potential)
		var new_room = available.pop_at(Global.rng.randi_range(0, available.size() - 1))
		makeRoomTypeAt(new_room, generate_random_room(room.distance_from_initial + 1))
		addConnection(room.tile_location, new_room)

		# Can't have a subpath before 2 room and can't have more than 2 subpaths
		if x > 2 and subpath_count < 2 and last_subpath != x - 1 and available.size() != 0:
			# 50% on 3, 75% on 4, and 100% on 5
			if Global.rng.randi_range(0, 3) < (abs(last_subpath - x) - 1):
				var sideRoom = available.pop_at(Global.rng.randi_range(0, available.size() - 1))
				makeRoomTypeAt(sideRoom, generate_random_room(room.distance_from_initial + 1))
				addConnection(room.tile_location, sideRoom)
				sidePath(rooms[sideRoom.x][sideRoom.y])
				last_subpath = x

		room = rooms[new_room.x][new_room.y]
	
	var available = findAvailable(room.tile_location)
	var new_room = available.pop_at(Global.rng.randi_range(0, available.size() - 1))
	makeRoomTypeAt(new_room, generate_random_room(room.distance_from_initial + 1) if boss_rooms == 1 else Global.roomType.BOSS)
	addConnection(new_room, room.tile_location)


func sidePath(room : RoomIcon):
	var length = Global.rng.randi_range(3, 4)
	var last_sideroom = 0
	var sideroom_count = 0

	for x in range(0, length):
		var available = findAvailable(room.tile_location)
		var new_room = available.pop_at(Global.rng.randi_range(0, available.size() - 1))
		makeRoomTypeAt(new_room, generate_random_room(room.distance_from_initial + 1))
		addConnection(room.tile_location, new_room)
		room = rooms[new_room.x][new_room.y]

func sideRoom(room: RoomIcon):
	pass

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
			rooms[location.x][location.y].behavior = generate_behavior(Global.roomType.COMBAT)
		Global.roomType.UNKNOWN:
			event_rooms += 1
			rooms[location.x][location.y].setup(Global.roomType.UNKNOWN, null, null)
			rooms[location.x][location.y].behavior = generate_behavior(Global.roomType.UNKNOWN)
		Global.roomType.BOSS:
			boss_rooms += 1
			rooms[location.x][location.y].setup(Global.roomType.BOSS, null, null)
			rooms[location.x][location.y].behavior = generate_behavior(Global.roomType.BOSS)
	
	rooms[location.x][location.y].tile_location = location
	
func generate_random_room(distance_from_initial: int, n_path_type : ActLayoutFactory.pathType = ActLayoutFactory.pathType.MAINPATH)-> Global.roomType:
	match n_path_type:
		ActLayoutFactory.pathType.MAINPATH:
			if distance_from_initial > 2:
				var possibleRooms = [Global.roomType.ELITE, Global.roomType.COMBAT, Global.roomType.UNKNOWN, Global.roomType.SHOP]
				var rates = [max(3 - elite_rooms, 0), max(10 - combat_rooms, 0), max(6 - event_rooms), max(1 - shop_rooms)]
				return possibleRooms[Global.rng.rand_weighted(rates)]
			else:
				var possibleRooms = [Global.roomType.COMBAT, Global.roomType.UNKNOWN]
				var rates = [max(10 - combat_rooms, 0), max(6 - event_rooms, 0)]
				return possibleRooms[Global.rng.rand_weighted(rates)]
	
	return Global.roomType.INITIAL
		
func generate_behavior(behavior_type : Global.roomType = Global.roomType.COMBAT) -> Callable:

	match behavior_type:
		Global.roomType.COMBAT:
			return func():
				Global.level_number = 2
				Global.level_changed.emit()
				Global.combatActive = true
		Global.roomType.UNKNOWN:
			return func():
				var event = ReflectionMirror.new()
				event.setup()
				var eventNode : EventNode = load("res://Scenes/UI/Events/EventNode.tscn").instantiate()
				eventNode.event = event
				Global.canvas_layer.add_child(eventNode)
				Global.canvas_layer.move_child(eventNode, -1)
		
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

func connectToAllAdajacentAboveDistance(location: Vector2i, distance_from_initial : int = 0):
	if distance_from_initial == 0 :
		distance_from_initial = rooms[location.x][location.y].distance_from_initial

	for x in range(0, 4):
		var room = null
		var curr_location = Vector2i(0,0)
		match x:
			0:
				curr_location = location + Vector2i(0, -1)
				room = rooms[location.x][location.y - 1]
			1:
				curr_location = location + Vector2i(1, 0)
				room = rooms[location.x + 1][location.y - 1]
			2:
				curr_location = location + Vector2i(0, 1)
				room = rooms[location.x][location.y + 1]
			3:
				curr_location = location + Vector2i(-1, 0)
				room = rooms[location.x - 1][location.y]
		
		if room == null or room.distance_from_initial < distance_from_initial:
			continue
		else:
			addConnection(location, curr_location)			
	pass

func withinBounds(location : Vector2i):
	if location.x < 0 or location.x >= rooms.size():
		return false
	if location.y < 0 or location.y >= rooms[0].size():
		return false
	return true
