@tool

# Entity Post-Import Template for LDTK-Importer.

func post_import(entity_layer: LDTKEntityLayer) -> LDTKEntityLayer:
	var definition: Dictionary = entity_layer.definition
	var entities: Array = entity_layer.entities

	# print("EntityLayer: ", entity_layer.name, " | Count: ", entities.size())

	for entity in entities:
		if entity.identifier == "CharacterStart":
			print("hello")


	return entity_layer
