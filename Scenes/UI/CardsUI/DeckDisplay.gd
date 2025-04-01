extends VBoxContainer

var card_container_scene = preload("res://Scenes/UI/CardsUI/CardContainer/card_container.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Display deck in 5xX grid
func dispDeck(deck: Deck):
	var count = 0
	var box : HBoxContainer = null
	for action in deck.actions:
		if count % 5 == 0:
			box = HBoxContainer.new()
			self.add_child(box)

		var padding = MarginContainer.new()
		box.add_child(padding)
		var cardcontainer = card_container_scene.instantiate()
		var x = (get_viewport().size.x / 6) - cardcontainer.size.x
		var y = cardcontainer.size.y + 50
		padding.add_theme_constant_override("margin_left", x)
		padding.add_theme_constant_override("margin_top", y)
		padding.size = Vector2(x, y)
		box.add_child(cardcontainer)
		cardcontainer.setAction(action, true)
		count += 1

# Combat deck has special rules to not display cards in order so it needs to new which cards are "known"
func dispCombatDeck(random_actions: Array[Action], ordered_actions : Array[Action]):
	var count = 0
	var box : HBoxContainer = null
	if random_actions.size() + ordered_actions.size() == 0:
		print("No cards in deck")
	
	for action in random_actions:
		if count % 5 == 0:
			box = HBoxContainer.new()
			self.add_child(box)
		
		var padding = MarginContainer.new()
		box.add_child(padding)
		var cardcontainer = card_container_scene.instantiate()
		var x = (get_viewport().size.x / 6) - cardcontainer.size.x
		var y = cardcontainer.size.y + 50
		padding.add_theme_constant_override("margin_left", x)
		padding.add_theme_constant_override("margin_top", y)
		padding.size = Vector2(x, y)
		box.add_child(cardcontainer)
		cardcontainer.setAction(action, true)
		count += 1
		
	for action in ordered_actions:
		if count % 5 == 0:
			box = HBoxContainer.new()
			self.add_child(box)
		
		var padding = MarginContainer.new()
		box.add_child(padding)
		var cardcontainer = card_container_scene.instantiate()
		var x = (DisplayServer.screen_get_size().x / 6) - cardcontainer.size.x
		var y = cardcontainer.size.y + 50
		padding.add_theme_constant_override("margin_left", x)
		padding.add_theme_constant_override("margin_top", y)
		padding.size = Vector2(x, y)
		box.add_child(cardcontainer)
		cardcontainer.setAction(action, true)
		count += 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
