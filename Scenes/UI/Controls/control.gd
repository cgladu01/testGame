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
@onready var layoutMap : LayoutMap =$"../../LayoutMap"

var scene = preload("res://Scenes/UI/EntityUI/pannelWindow.tscn")
var window = null

var confirmscene = preload("res://Scenes/UI/Controls/Confirmation.tscn")
var confirmWindow = null

var pausescene = preload("res://Scenes/Menu/PauseScreen.tscn")
var pauseScreenWindow = null

var decksceneload = preload("res://Scenes/UI/CardsUI/DisplayDeck.tscn")
var deckscene = null
var discardDeckscene = null

var character_hands_load = preload("res://Scenes/UI/CardsUI/SeeAllHands.tscn")
var character_hands_scene = null


# Hover related stuff
var lastHover : Vector2i = Vector2i(0,0)
var lastHoverSelection : Vector2i = Vector2i(3, 12)
var click : bool = false

var prevSpot : Vector2i = Vector2i(0, 0)
var tileManager : TileManager = null
var character : Character = null
var prevSelection : Vector2i = Vector2i(3, 12)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/HBoxContainer/VBoxContainer/EndTurn.EndTurnPlayerTurn.connect(_onEndTurn)
	Global.confirmationWindow.connect(_makeConfirmationWindow)
	Global.roundStart.connect(_onRoundStart)
	Global.update_hand.connect(_onUpdateHand)
	Global.confirm_pressed.connect(_on_confirm_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var tile = selection.local_to_map(mouse_pos)

	if Global.currentAction is SplashAction:
		var splashAction = Global.currentAction as SplashAction
		if not click:
			splashAction.hover_event(lastHover, true)

		if prevSpot != tile:
			click = false
			lastHover = tile
			splashAction.hover_event(tile, false)
		elif selection.get_cell_atlas_coords(tile) != Vector2i(3, 0):
			click = true
			prevSelection = Vector2i(-1,-1)
			splashAction.click_event(tile, false)

	else:
		if not click:
			selection.set_cell(lastHover, 11, lastHoverSelection)
		
		if prevSpot != tile:
			click = false
			lastHover = tile
			lastHoverSelection = selection.get_cell_atlas_coords(tile)
			selection.set_cell(tile, 11, Vector2i(3,7))
		elif selection.get_cell_atlas_coords(tile) != Vector2i(3, 0):
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
	if event.is_action_pressed("MouseClick"):
		if tileManager == null:
			tileManager = world.return_tileManager()
			
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = terrain.local_to_map(mouse_pos)
		if tile_mouse_pos != prevSpot and prevSelection != Vector2i(2,7):
			
			if Global.currentAction is SplashAction:
				var splashAction = Global.currentAction as SplashAction
				splashAction.click_event(prevSpot, true)
			else:
				selection.set_cell(prevSpot, 11, prevSelection)

		if tile_mouse_pos == prevSpot and is_instance_valid(confirmWindow):
			confirmWindow._on_confirm_pressed()
		prevSpot = tile_mouse_pos
		click = true
		var tile = tileManager.get_tile(Vector3i(tile_mouse_pos.x, tile_mouse_pos.y, 1))

		# If tile is entity display enemy actions or if character display hand
		if tile is Entities and Global.combatActive:
			
			if tile is Character:
				character = tile as Character
				action_menu_control.on_action_update(character.hand, character.energy, character.max_energy)
				character.clicked()

			if window == null:
				window = scene.instantiate()
				canvas_layer.add_child(window)
			if tile is Enemy:
				var enemy = tile as Enemy
				enemy.node.dispActionline()
			else:
				units.clearActionLine()

			window.set_entityDisplay(tile as Entities)

		if Global.currentAction is TargetedAction:
			var targettedAction = Global.currentAction as TargetedAction
			if targettedAction.validTarget(character, tileManager.get_tile(Vector3i(tile_mouse_pos.x, tile_mouse_pos.y, 1)), tileManager):
				prevSelection = Vector2i(2,7)
				Global.confirmationWindow.emit()

	elif event.is_action_pressed("Pause"):
		if pauseScreenWindow == null:
			pauseScreenWindow = pausescene.instantiate()
			canvas_layer.add_child(pauseScreenWindow)
		else:
			pauseScreenWindow.queue_free()
			pauseScreenWindow = null

	elif event.is_action_pressed("View Combat Deck"):
		changeOverlay("View Combat Deck")
	
	elif event.is_action_pressed("View Deck"):
		changeOverlay("View Deck")
			
	elif event.is_action_pressed("Pitch"):
		Global.select_mode = PitchMode.new()
		Global.select_mode.setup(character)
		_makeConfirmationWindow()
	
	elif event.is_action_pressed("See All Hands"):
		changeOverlay("See All Hands")
	
	elif event.is_action_pressed("View Map"):
		if layoutMap.is_visible():
			layoutMap.visible = false
		else:
			layoutMap.visible = true



	elif event is InputEventKey:
		var direction: Vector2 = Input.get_vector("CameraLeft", "CameraRight", "CameraUp", "CameraDown")
		camera_2d.position += direction * 10

func changeOverlay(overlay: String):

	match overlay:
		"See All Hands":
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

			if deckscene == null and character != null:
				deckscene = decksceneload.instantiate()
				canvas_layer.add_child(deckscene)
				deckscene.dispDeck(character.deck)
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
			
			if discardDeckscene == null and character != null:
				discardDeckscene = decksceneload.instantiate()
				canvas_layer.add_child(discardDeckscene)
				discardDeckscene.dispCombatDeck(character.combatDeck.random_actions(character.deck), character.combatDeck.non_random_actions())
			elif discardDeckscene != null:
				discardDeckscene.queue_free()
				discardDeckscene = null

func _onEndTurn():
	if is_instance_valid(confirmWindow):
		confirmWindow.queue_free()

func _onRoundStart():
	if character:
		action_menu_control.on_action_update(character.hand, character.energy, character.max_energy)

func _onUpdateHand():
	if character:
		action_menu_control.on_action_update(character.hand, character.energy, character.max_energy)

func _makeConfirmationWindow():
	if confirmWindow == null:
		confirmWindow = confirmscene.instantiate()
		canvas_layer.add_child(confirmWindow)

func _on_confirm_pressed():
	if Global.currentAction is SplashAction:
		var splashAction = Global.currentAction as SplashAction
		splashAction.click_event(prevSpot, true)
	else:
		selection.set_cell(prevSpot, 11, prevSelection)
	
	prevSpot = Vector2i(-1,-1)
