extends Control
var terrain: TileMapLayer = null
@onready var layerholder = $"../../Layerholder"
@onready var selection: TileMapLayer = $"../../Layerholder/selection"
@onready var camera_2d: Camera2D = $"../../Camera2D"
@onready var action_menu_control: Control = $PanelContainer/HBoxContainer/ActionMenu
@onready var world: Node2D = $"../.."
@onready var canvas_layer: CanvasLayer = $".."
@onready var units : Node2D = $"../../Units"

var confirmscene = preload("res://Scenes/UI/Confirmation.tscn")
var scene = preload("res://Scenes/UI/pannelWindow.tscn")
var pausescene = preload("res://Scenes/Menu/PauseScreen.tscn")
var decksceneload = preload("res://Scenes/UI/DisplayDeck.tscn")
var window = null
var confirmWindow = null
var pauseScreenWindow = null
var deckscene = null

var prevSpot : Vector2i = Vector2i(0, 0)
var tileManager : TileManager = null
var character : Character = null
var prevSelection : Vector2i = Vector2i(3, 12)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/HBoxContainer/VBoxContainer/EndTurn.EndTurnPlayerTurn.connect(_onEndTurn)
	Global.confirmationWindow.connect(_makeConfirmationWindow)
	Global.roundStart.connect(_onRoundStart)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		accept_event()

func _unhandled_input(event: InputEvent) -> void:
	if terrain == null:
		terrain = Global.tile_map_layer
	if event.is_action_pressed("MouseClick"):
		print_orphan_nodes()
		if tileManager == null:
			tileManager = world.return_tileManager()
			
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = terrain.local_to_map(mouse_pos)
		if tile_mouse_pos != prevSpot and prevSelection != Vector2i(2,7):
			selection.set_cell(prevSpot, 11, prevSelection)
		if tile_mouse_pos == prevSpot and is_instance_valid(confirmWindow):
			confirmWindow._on_confirm_pressed()

		prevSpot = tile_mouse_pos
		prevSelection = selection.get_cell_atlas_coords(prevSpot)
		selection.set_cell(tile_mouse_pos, 11, Vector2i(3,7))
		

		var tile = tileManager.get_tile(Vector3i(tile_mouse_pos.x, tile_mouse_pos.y, 1))

		if tile is Entities:
			
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

	elif  event.is_action_pressed("View Deck"):
		if deckscene == null and character != null:
			deckscene = decksceneload.instantiate()
			canvas_layer.add_child(deckscene)
			deckscene.dispDeck(character.deck)
		elif deckscene != null:
			deckscene.queue_free()
			deckscene = null
		pass

	elif event is InputEventKey:
		var direction: Vector2 = Input.get_vector("CameraLeft", "CameraRight", "CameraUp", "CameraDown")
		camera_2d.position += direction * 10

func _onEndTurn():
	if is_instance_valid(confirmWindow):
		confirmWindow.queue_free()

func _onRoundStart():
	if character:
		action_menu_control.on_action_update(character.hand, character.energy, character.max_energy)

func _makeConfirmationWindow():
	if confirmWindow == null:
		confirmWindow = confirmscene.instantiate()
		canvas_layer.add_child(confirmWindow)
