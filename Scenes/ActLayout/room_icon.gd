class_name RoomIcon extends Control

@onready var sprite : Sprite2D = $"Container/Sprite2D"

const SEPERATION = 65
const CONNECTOR_SEPERATOR = 5
const CONNECTOR_MIDIAN = 15
const ICON_SIZE = 60

var type = Global.roomType.UNKNOWN
var explored = false
var completed = false
var current = false

var up : RoomIcon = null
var right : RoomIcon = null
var down : RoomIcon = null
var left : RoomIcon = null

var behavior : Callable = func (): print("No function")


func setup(n_type : Global.roomType = Global.roomType.INITIAL,
	n_up : RoomIcon = null, n_right : RoomIcon = null, n_down : RoomIcon = null, n_left : RoomIcon = null):
	type = n_type 
	up = n_up
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
		
	set_image()


func add_adajacent_room(i_direction: Global.direction, room: RoomIcon):

	match i_direction:
		Global.direction.UP:
			up = room
			room.down = self
			room.position = self.position - Vector2(0, SEPERATION)
			var panel = Panel.new()
			panel.size = Vector2(30,5)
			get_parent().add_child(panel)
			panel.position = self.position - Vector2(-CONNECTOR_MIDIAN, CONNECTOR_SEPERATOR)
		
		Global.direction.RIGHT:
			right = room
			room.left = self
			room.position = self.position + Vector2(SEPERATION, 0)
			var panel = Panel.new()
			panel.size = Vector2(5,30)
			get_parent().add_child(panel)
			panel.position = self.position + Vector2(ICON_SIZE, CONNECTOR_MIDIAN)

		Global.direction.DOWN:
			down = room
			room.up = self
			room.position = self.position + Vector2(0, SEPERATION)
			var panel = Panel.new()
			panel.size = Vector2(30,5)
			get_parent().add_child(panel)
			panel.position = self.position + Vector2(CONNECTOR_MIDIAN, ICON_SIZE)
		
		Global.direction.LEFT:
			left = room
			room.right = self
			room.position = self.position - Vector2(SEPERATION, 0)
			var panel = Panel.new()
			panel.size = Vector2(5,30)
			get_parent().add_child(panel)
			panel.position = self.position - Vector2(CONNECTOR_SEPERATOR, -CONNECTOR_MIDIAN)

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


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseClick"):
		get_parent().get_parent().get_parent().get_parent().changeRoom(self)
