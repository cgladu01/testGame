extends HBoxContainer
var enemy:Enemy = null
# Dipslays enemy intents

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_enemy(new_enemy: Enemy) -> void:
	enemy = new_enemy

func update_actions():
	for child in get_children():
		child.queue_free()

	for image_path in enemy.action.imageIndicator:
			var image_status = Image.new()
			image_status.load(image_path)
			image_status.resize(15, 15)
			var texture = ImageTexture.create_from_image(image_status)
			var textureRect = TextureRect.new()
			textureRect.texture = texture
			self.add_child(textureRect)
