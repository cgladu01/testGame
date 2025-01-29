extends Node2D
var currentlevel = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_level(level_number: int):
	currentlevel = load(str("res://Scenes/Maps/LDTK/levels/Level_", level_number, ".scn")).instantiate()
	self.add_child(currentlevel)
	self.move_child(currentlevel, 0)
	Global.tile_map_layer = currentlevel.get_child(0)
	pass
