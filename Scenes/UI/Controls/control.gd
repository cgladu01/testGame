extends Control
var terrain: TileMapLayer = null
# responsible for handling all player input
# Might be disolved into smaller pieces IDK


@onready var layerholder = $"../../Layerholder"
@onready var selection: TileMapLayer = $"../../Layerholder/selection"
@onready var camera_2d: Camera2D = $"../../Camera2D"
@onready var action_menu_control: Control = $PanelContainer/HBoxContainer/ActionMenu
@onready var world: Node2D = $"../.."
@onready var canvas_layer: CanvasLayer = $".."
@onready var units : Node2D = $"../../Units"
@onready var layoutMap : LayoutMap =$"../LayoutMap"


var scene = preload("res://Scenes/UI/EntityUI/pannel_window.tscn")
var window = null

var confirmscene = preload("res://Scenes/UI/Controls/confirmation.tscn")
var confirmWindow = null

var pausescene = preload("res://Scenes/Menu/pause_screen.tscn")
var pauseScreenWindow = null

var decksceneload = preload("res://Scenes/UI/CardsUI/display_deck.tscn")
var deckscene = null
var discardDeckscene = null

var character_hands_load = preload("res://Scenes/UI/CardsUI/see_all_hands.tscn")
var character_hands_scene = null

var no_character_selected_load = preload("res://Scenes/UI/Controls/no_character_selected_panel.tscn")

signal _on_map_pressed
signal _on_pause_pressed


# Hover related stuff
var lastHover : Vector2i = Vector2i(0,0)
var lastHoverSelection : Vector2i = Vector2i(3, 12)
var click : bool = false

var lastClicked : Vector2i = Vector2i(0, 0)
var tileManager : TileManager = null
var prevSelection : Vector2i = Vector2i(3, 12)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/HBoxContainer/VBoxContainer/EndTurn.EndTurnPlayerTurn.connect(_onEndTurn)
	Global.confirmationWindow.connect(_makeConfirmationWindow)
	Global.roundStart.connect(_onRoundStart)
	Global.update_hand.connect(_onUpdateHand)
	Global.confirm_pressed.connect(_on_confirm_pressed)
	_on_map_pressed.connect(_layout_map)
	_on_pause_pressed.connect(_pause_screen)
	Global.selected_character_update.connect(_selected_character)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not self.visible:
		return
		
	var mouse_pos = get_global_mouse_position() + camera_2d.position
	var tile = selection.local_to_map(mouse_pos)

	if Global.currentAction is SplashAction:
		var splashAction = Global.currentAction as SplashAction
		if not click:
			splashAction.hover_event(lastHover, true)

		if lastClicked != tile:
			click = false
			lastHover = tile
			splashAction.hover_event(tile, false)
		elif selection.get_cell_atlas_coords(tile) != Vector2i(3, 0):
			click = true
			prevSelection = Vector2i(-1,-1)
			splashAction.click_event(tile, false)

	else:
		# Reset the last hovered value to whatever it was before
		if not click:
			selection.set_cell(lastHover, 11, lastHoverSelection)
		
		# Replace the last hovered spot whatever it was before the hover.
		if lastClicked != tile:
			click = false
			lastHover = tile
			lastHoverSelection = selection.get_cell_atlas_coords(tile)
			selection.set_cell(tile, 11, Vector2i(3,7))
		# If this tile is not the selection button store it to be replaced
		elif selection.get_cell_atlas_coords(tile) != Vector2i(3, 0):
			if Global.currentAction is Move:
				Global.update_mock_locations()
				var character_spot = 0
				for character in Global.characters:
					if character.name == Global.selected_character.name:
						break
					character_spot += 1
					
				Global.mock_locations[character_spot] = tile
				units.display_targeting(false)
			click = true
			prevSelection = lastHoverSelection
			selection.set_cell(tile, 11, Vector2i(3,0))

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		accept_event()

func _unhandled_input(event: InputEvent) -> void:

	if GDConsole.visible:
		return

	if terrain == null:
		terrain = Global.tile_map_layer
	if event.is_action_pressed("MouseClick") and visible:
		if tileManager == null:
			tileManager = world.return_tileManager()
			
		var mouse_pos = get_global_mouse_position() + camera_2d.position
		var tile_mouse_pos = terrain.local_to_map(mouse_pos)
		if tile_mouse_pos != lastClicked and prevSelection != Vector2i(2,7):
			
			if Global.currentAction is SplashAction:
				var splashAction = Global.currentAction as SplashAction
				splashAction.click_event(lastClicked, true)
			else:
				selection.set_cell(lastClicked, 11, prevSelection)

		if tile_mouse_pos == lastClicked and is_instance_valid(confirmWindow):
			confirmWindow._on_confirm_pressed()
		lastClicked = tile_mouse_pos
		click = true
		var tile = tileManager.get_tile(Vector3i(tile_mouse_pos.x, tile_mouse_pos.y, 1))

		# If tile is entity display enemy actions or if character display hand
		if tile is Entities and Global.combatActive:
			
			if tile is Character:
				select_character(tile as Character)

			if window == null:
				window = scene.instantiate()
				canvas_layer.add_child(window)
			if tile is Enemy:
				var enemy = tile as Enemy
				enemy.node.dispActionline()
			else:
				units.clear_action_line()

			window.set_entityDisplay(tile as Entities)

		if Global.currentAction is TargetedAction:
			var targettedAction = Global.currentAction as TargetedAction
			if targettedAction.validTarget(Global.selected_character, tileManager.get_tile(Vector3i(tile_mouse_pos.x, tile_mouse_pos.y, 1)), tileManager):
				prevSelection = Vector2i(2,7)
				Global.confirmationWindow.emit()

	elif event.is_action_pressed("Pause"):
		_on_pause_pressed.emit()

	elif event.is_action_pressed("View Combat Deck") and visible:
		changeOverlay("View Combat Deck")
	
	elif event.is_action_pressed("View Deck") and visible:
		changeOverlay("View Deck")
			
	elif event.is_action_pressed("Pitch") and visible:
		Global.select_mode = PitchMode.new()
		Global.select_mode.setup(Global.selected_character)
		_makeConfirmationWindow()
	
	elif event.is_action_pressed("See All Hands") and visible:
		changeOverlay("See All Hands")
	
	elif event.is_action_pressed("View Map"):
		_on_map_pressed.emit()

	elif event is InputEventKey and visible:
		var direction: Vector2 = Input.get_vector("CameraLeft", "CameraRight", "CameraUp", "CameraDown")
		camera_2d.position += direction * 10

func select_character(character : Character, emit_update : bool = true):

	Global.selected_character = character
	if emit_update:
		Global.selected_character_update.emit()
	
	if Global.selected_character != null:
		action_menu_control.on_action_update(character.hand, character.energy, character.max_energy)
		character.clicked()
	
	if window == null:
		window = scene.instantiate()
		canvas_layer.add_child(window)
	
	window.set_entityDisplay(character)


func changeOverlay(overlay: String):

	match overlay:
		"See All Hands":
			if Global.combatActive:
				if deckscene != null:
					deckscene.queue_free()
					deckscene = null
				
				if discardDeckscene != null:
					discardDeckscene.queue_free()
					discardDeckscene = null

				if character_hands_scene == null:
					character_hands_scene = character_hands_load.instantiate()
					canvas_layer.add_child(character_hands_scene)
					character_hands_scene.displayAllHands()
				elif character_hands_scene != null:
					character_hands_scene.queue_free()
					deckscene = null
		
		"View Deck":
			if discardDeckscene != null:
				discardDeckscene.queue_free()
				discardDeckscene = null

			if character_hands_scene != null:
				character_hands_scene.queue_free()
				character_hands_scene = null

			if Global.selected_character == null:
				canvas_layer.add_child(no_character_selected_load.instantiate())
			elif deckscene == null:
				deckscene = decksceneload.instantiate()
				canvas_layer.add_child(deckscene)
				deckscene.dispDeck(Global.selected_character.deck)
			elif deckscene != null:
				deckscene.queue_free()
				deckscene = null
		
		"View Combat Deck":
			if deckscene != null:
				deckscene.queue_free()
				deckscene = null

			if character_hands_scene != null:
				character_hands_scene.queue_free()
				character_hands_scene = null
			
			if Global.selected_character == null:
				canvas_layer.add_child(no_character_selected_load.instantiate())
			elif discardDeckscene == null:
				discardDeckscene = decksceneload.instantiate()
				canvas_layer.add_child(discardDeckscene)
				discardDeckscene.dispCombatDeck(Global.selected_character.combatDeck.random_actions(
					Global.selected_character.deck), Global.selected_character.combatDeck.non_random_actions())
			elif discardDeckscene != null:
				discardDeckscene.queue_free()
				discardDeckscene = null

func _onEndTurn():
	units.clear_action_line()
	if is_instance_valid(confirmWindow):
		confirmWindow.queue_free()

func _layout_map():
	Global.toggle_map.emit()

func _pause_screen():
	if pauseScreenWindow == null:
		pauseScreenWindow = pausescene.instantiate()
		canvas_layer.add_child(pauseScreenWindow)
	else:
		pauseScreenWindow.queue_free()
		pauseScreenWindow = null

func _onRoundStart():
	if Global.selected_character:
		action_menu_control.on_action_update(Global.selected_character.hand, Global.selected_character.energy, Global.selected_character.max_energy)

func _onUpdateHand():
	if Global.selected_character:
		action_menu_control.on_action_update(Global.selected_character.hand, Global.selected_character.energy, Global.selected_character.max_energy)

func _makeConfirmationWindow():
	if confirmWindow == null:
		confirmWindow = confirmscene.instantiate()
		canvas_layer.add_child(confirmWindow)

func _on_confirm_pressed():
	if Global.currentAction is SplashAction:
		var splashAction = Global.currentAction as SplashAction
		splashAction.click_event(lastClicked, true)
	else:
		selection.set_cell(lastClicked, 11, prevSelection)
	
	lastClicked = Vector2i(-1,-1)


func _on_view_discard_pressed() -> void:
	changeOverlay("View Deck")

func _on_view_draw_pressed() -> void:
	changeOverlay("View Combat Deck")

func _selected_character() -> void:
	if discardDeckscene != null:
		discardDeckscene.queue_free()
		discardDeckscene = null
	if deckscene != null:
		deckscene.queue_free()
		deckscene = null
	if character_hands_scene != null:
		character_hands_scene.queue_free()
		character_hands_scene = null
	select_character(Global.selected_character, false)
