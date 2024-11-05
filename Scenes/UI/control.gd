extends Control
@onready var terrain: TileMapLayer = $"../../Layerholder/terrain"
@onready var selection: TileMapLayer = $"../../Layerholder/selection"
@onready var camera_2d: Camera2D = $"../../Camera2D"
@onready var action_menu_control: Control = $PanelContainer/ActionMenu
@onready var world: Node2D = $"../.."
@onready var canvas_layer: CanvasLayer = $".."

var scene = preload("res://Scenes/UI/pannelWindow.tscn")
var window = null
var prevSpot : Vector2i = Vector2i(0, 0)
var tileManager : TileManager = null
var character : Character = null
var prevSelection : Vector2i = Vector2i(3, 12)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/EndTurn.EndTurnPlayerTurn.connect(_onEndTurn)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		accept_event()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("MouseClick"):
		if tileManager == null:
			tileManager = world.return_tileManager()
			
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = terrain.local_to_map(mouse_pos)
		if tile_mouse_pos != prevSpot:
			selection.set_cell(prevSpot, 11, prevSelection)
		prevSpot = tile_mouse_pos
		prevSelection = selection.get_cell_atlas_coords(prevSpot)
		selection.set_cell(tile_mouse_pos, 11, Vector2i(3,7))
		
		var tile = tileManager.get_tile(Vector3i(tile_mouse_pos.x, tile_mouse_pos.y, 1))
		
		if tile is Entities:
			
			if tile is Character:
				character = tile as Character
				action_menu_control.on_action_update(character.actions as Array[Action], character.energy, character.max_energy)

			if window == null:
				window = scene.instantiate()
				canvas_layer.add_child(window)
			window.set_entityDisplay(tile as Entities)

		elif Global.selection == false:
			action_menu_control.on_action_update([] as Array[Action], 0, 0)
		if Global.currentAction is TargetedAction:
			var targettedAction = Global.currentAction as TargetedAction
			if targettedAction.validTarget(character, tileManager.get_tile(Vector3i(tile_mouse_pos.x, tile_mouse_pos.y, 1)), tileManager):
				targettedAction.execute()
				action_menu_control.action_menu_clear(Global.currentAction.name)
				Global.currentAction = null
				Global.selection = false
			
	elif event is InputEventKey:
		var direction: Vector2 = Input.get_vector("CameraLeft", "CameraRight", "CameraUp", "CameraDown")
		camera_2d.position += direction * 10
		
	pass

func _onEndTurn():
	action_menu_control.on_action_update([] as Array[Action], 0, 0)
