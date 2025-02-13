extends GridContainer

var card_container_scene = preload("res://Scenes/UI/card_container.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func dispDeck(deck: Deck):
	for action in deck.actions:
		var padding = MarginContainer.new()
		self.add_child(padding)
		var cardcontainer = card_container_scene.instantiate()
		var x = (DisplayServer.screen_get_size().x / 6) - cardcontainer.size.x
		var y = cardcontainer.size.y + 50
		padding.add_theme_constant_override("margin_left", x)
		padding.add_theme_constant_override("margin_top", y)
		padding.size = Vector2(x, y)
		self.add_child(cardcontainer)
		cardcontainer.setAction(action)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
