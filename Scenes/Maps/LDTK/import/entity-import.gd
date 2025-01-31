@tool

# Entity Post-Import Template for LDTK-Importer.

func post_import(entity_layer: LDTKEntityLayer) -> LDTKEntityLayer:
	var tiles = entity_layer.get_parent().get_child(0) as TileMapLayer
	var entities: Array = entity_layer.entities

	# print("EntityLayer: ", entity_layer.name, " | Count: ", entities.size())

	for entity in entities:
		if entity.identifier == "CharacterStart":
			var characterNode = CharacterNode.new()
			characterNode.name = str("Character ", entity.fields["CharacterNum"])
			characterNode.characterNum = entity.fields["CharacterNum"]
			characterNode.position = match_to_local(entity.position, tiles)
			entity_layer.add_child(characterNode)
		elif entity.identifier == "Enemy":
			if entity.fields["Type"] == "Wolf":
				var entityNode = EntitiyNode.new()
				entityNode.name = str("Wolf ", entity.fields["Count"])
				entityNode.position = match_to_local(entity.position, tiles)
				entity_layer.add_child(entityNode)

	return entity_layer


func match_to_local(position :Vector2i, tiles : TileMapLayer) -> Vector2:
	return tiles.map_to_local(tiles.local_to_map(position))




