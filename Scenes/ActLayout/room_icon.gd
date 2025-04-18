class_name RoomIcon extends Control

@onready var sprite : Sprite2D = $"Container/Sprite2D"

const SEPERATION = 65
const CONNECTOR_SEPERATOR = 5
const CONNECTOR_MIDIAN = 15
const ICON_SIZE = 60

var type = Global.roomType.UNKNOWN

# Room is discovered 
var discovered = false

# Room is done and there are not other actions to be done it.
var completed = false
var current = false

var up : RoomIcon = null
var upSeperator : Panel = null
var right : RoomIcon = null
var rightSeperator: Panel = null
var down : RoomIcon = null
var downSeperator : Panel = null
var left : RoomIcon = null
var leftSeperator : Panel = null

var tile_location : Vector2i = Vector2i(0, 0)

var distance_from_initial = 0
var behavior : Callable = func (): print("No function")

func _ready():
	set_image()
	for seperator in [upSeperator, rightSeperator, downSeperator, leftSeperator]:
		if seperator:
			get_parent().add_child(seperator)
	
	position_spacers()

func setup(n_type : Global.roomType = Global.roomType.INITIAL,
	n_up : RoomIcon = null, n_right : RoomIcon = null, n_down : RoomIcon = null, n_left : RoomIcon = null, n_distance_from_initial = 0):
	type = n_type 
	up = n_up
	if type != Global.roomType.INITIAL:
		visible = false
	else:
		set_discovered()
		set_completed()

	if up != null:
		up.add_adajacent_room(Global.direction.DOWN, self)

	right = n_right
	if right != null:
		right.add_adajacent_room(Global.direction.LEFT, self)

	down = n_down
	if down != null:
		down.add_adajacent_room(Global.direction.UP, self)

	left = n_left
	if left != null:
		left.add_adajacent_room(Global.direction.RIGHT, self)
	
	distance_from_initial = n_distance_from_initial

func add_adajacent_room(i_direction: Global.direction, room: RoomIcon):

	match i_direction:
		Global.direction.UP:
			up = room
			room.down = self
			room.position = self.position - Vector2(0, SEPERATION)
			room.visible = completed
			upSeperator = Panel.new()
			room.downSeperator = upSeperator
			upSeperator.size = Vector2(30,5)
			if get_parent() != null:
				get_parent().add_child(upSeperator)
			upSeperator.visible = visible
			upSeperator.position = self.position - Vector2(-CONNECTOR_MIDIAN, CONNECTOR_SEPERATOR)
		
		Global.direction.RIGHT:
			right = room
			room.left = self
			room.position = self.position + Vector2(SEPERATION, 0)
			room.visible = completed
			rightSeperator = Panel.new()
			room.leftSeperator = rightSeperator
			rightSeperator.size = Vector2(5,30)
			if get_parent() != null:
				get_parent().add_child(rightSeperator)
			rightSeperator.visible = visible
			rightSeperator.position = self.position + Vector2(ICON_SIZE, CONNECTOR_MIDIAN)

		Global.direction.DOWN:
			down = room
			room.up = self
			room.position = self.position + Vector2(0, SEPERATION)
			room.visible = completed
			downSeperator = Panel.new()
			room.upSeperator = downSeperator
			downSeperator.size = Vector2(30,5)
			if get_parent() != null:
				get_parent().add_child(downSeperator)
			downSeperator.visible = visible
			downSeperator.position = self.position + Vector2(CONNECTOR_MIDIAN, ICON_SIZE)
		
		Global.direction.LEFT:
			left = room
			room.right = self
			room.position = self.position - Vector2(SEPERATION, 0)
			room.visible = completed
			leftSeperator = Panel.new()
			room.rightSeperator = leftSeperator
			leftSeperator.size = Vector2(5,30)
			if get_parent() != null:
				get_parent().add_child(leftSeperator)
			leftSeperator.visible = visible
			leftSeperator.position = self.position - Vector2(CONNECTOR_SEPERATOR, -CONNECTOR_MIDIAN)

func set_image():
	var image_path = ""

	match type:
		Global.roomType.UNKNOWN:
			image_path = "res://icons/789_Lorc_RPG_icons/Icon.5_47.png"
		Global.roomType.COMBAT:
			image_path = "res://icons/789_Lorc_RPG_icons/Icon.2_43.png"
		Global.roomType.ELITE:
			image_path = "res://icons/789_Lorc_RPG_icons/Icon.5_82.png"
		Global.roomType.BOSS:
			image_path = "res://icons/789_Lorc_RPG_icons/Icon.3_22.png"
		Global.roomType.SHOP:
			image_path = "res://icons/789_Lorc_RPG_icons/Icon.8_78.png"
		Global.roomType.INITIAL:
			image_path = "res://icons/789_Lorc_RPG_icons/Icon.2_58.png"
		Global.roomType.CAMPSITE:
			image_path = "res://icons/789_Lorc_RPG_icons/Icon.1_64.png"
		_:
			pass

	sprite.set_texture(load(image_path))
	sprite.scale = Vector2(0.125,0.125)


func set_discovered(n_discovered : bool = true):
	discovered = n_discovered
	if discovered:
		if upSeperator != null:
			upSeperator.visible = true
		if leftSeperator != null:
			leftSeperator.visible = true
		if rightSeperator != null:
			rightSeperator.visible = true
		if downSeperator != null:
			downSeperator.visible = true

func set_completed(n_completed : bool = true):
	completed = n_completed
	if completed:
		if up != null:
			up.visible = true
			up.set_discovered()
		if left != null:
			left.visible = true
			left.set_discovered()
		if right != null:
			right.visible = true
			right.set_discovered()
		if down != null:
			down.visible = true
			down.set_discovered()

func bfsAddTo(node : Node):
	node.add_child(self)

	if up != null and up.get_parent() == null:
		up.bfsAddTo(node)
	if left != null and left.get_parent() == null:
		left.bfsAddTo(node)
	if right != null and right.get_parent() == null:
		right.bfsAddTo(node)
	if down !=null and down.get_parent() == null:
		down.bfsAddTo(node)

func position_spacers():
		if upSeperator:
			if get_parent() != null:
				get_parent().add_child(upSeperator)
			upSeperator.visible = visible
			upSeperator.position = self.position - Vector2(-CONNECTOR_MIDIAN, CONNECTOR_SEPERATOR)
		
		if rightSeperator:
			if get_parent() != null:
				get_parent().add_child(rightSeperator)
			rightSeperator.visible = visible
			rightSeperator.position = self.position + Vector2(ICON_SIZE, CONNECTOR_MIDIAN)

		if downSeperator:
			if get_parent() != null:
				get_parent().add_child(downSeperator)
			downSeperator.visible = visible
			downSeperator.position = self.position + Vector2(CONNECTOR_MIDIAN, ICON_SIZE)
	
		if leftSeperator:
			if get_parent() != null:
				get_parent().add_child(leftSeperator)
			leftSeperator.visible = visible
			leftSeperator.position = self.position - Vector2(CONNECTOR_SEPERATOR, -CONNECTOR_MIDIAN)

func connected_rooms() -> Array[RoomIcon]:
	var returner : Array[RoomIcon] = []
	for x in [up,right,left,down]:
		if x != null:
			returner.append(x)
	
	return returner

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseClick"): 
		print(tile_location)
		get_parent().get_parent().get_parent().get_parent().changeRoom(self)
