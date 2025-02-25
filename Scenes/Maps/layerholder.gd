# This class is responsible for setting up the levels and creating the corresponding entities/characters for it.
extends Node2D
var currentlevel = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# This is called from world and makes the level depening on the number provided.
func generate_level(level_number: int):
	currentlevel = load(str("res://Scenes/Maps/LDTK/levels/Level_", level_number, ".scn")).instantiate()
	self.add_child(currentlevel)
	self.move_child(currentlevel, 0)
	Global.tile_map_layer = currentlevel.get_child(0)
	var entities: LDTKEntityLayer = null
	for child in currentlevel.get_children():
		if str(child.name) == "Entities":
			entities = child
			break
		
	Global.tileManager.setup([Global.tile_map_layer, Global.selectionTile] as Array[TileMapLayer], 21, 16, 2)
	
	for entity in entities.get_children():
		entities.remove_child(entity)
		
		if entity is CharacterNode:
			var characterNode: CharacterNode = entity as CharacterNode
			if Global.characterNames[characterNode.get_meta("number") - 1] != "" and Global.characters.size() < 2:
				Global.characterFactory.createCharacter(Global.characterNames[characterNode.get_meta("number") - 1], characterNode)
			else:
				characterNode.queue_free()
		else:
			Global.enemyFactory.createEnemy("Wolf", entity as EntitiyNode)
	
	entities.queue_free()
