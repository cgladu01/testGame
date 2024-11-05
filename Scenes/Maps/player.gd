class_name PlayerUnit extends UnitNode
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var terrain: TileMapLayer = $"../../../Layerholder/terrain"

var is_moving = false
var character: Character
signal moved

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move(direction: Vector2):
	var tween = create_tween()
	tween.tween_property(self, "position", terrain.map_to_local(direction), 0.2)
	tween.tween_callback(func(): emit_signal("moved"))

func move_along_path(path: Array[Vector2i]):
	for x in path:
		move(x + Global.tileShift)
		await moved
	pass

func set_character(character : Character):
	self.character = character
	
func refresh_Actions():
	for x in character.get_actions():
		x.used = false
