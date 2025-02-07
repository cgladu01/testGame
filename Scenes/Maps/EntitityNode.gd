class_name EntitiyNode extends Node2D

var scene = preload("res://Scenes/UI/actionline.tscn")
var is_moving = false
var entities: Entities
var actionLine = null
signal moved

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move(direction: Vector2):
	var tween = create_tween()
	tween.tween_property(self, "position", Global.tile_map_layer.map_to_local(direction), 0.2)
	tween.tween_callback(func(): emit_signal("moved"))

func move_along_path(path: Array[Vector2i]):
	for x in path:
		move(x + Global.tileShift)
		await moved
	pass

func set_entity(entity : Entities):
	self.entities = entity
	self.position = Global.tile_map_layer.map_to_local(entities.location + Global.tileShift)
	var sprite = Sprite2D.new()
	var image = Image.new()
	image.load(entity.spritePath)
	image.resize(16, 16)
	sprite.set_texture(ImageTexture.create_from_image(image))
	add_child(sprite)


func dispActionline():
	if entities is Enemy:
		if actionLine == null:
			actionLine = scene.instantiate()
			actionLine.set_enemy(entities as Enemy)
			self.add_child(actionLine)
			actionLine.position = actionLine.position - Vector2(15, 25)
		actionLine.update_actions()

func clearActionLine():
	if actionLine != null:
		actionLine.queue_free()
