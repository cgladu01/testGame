class_name EnemyFactory

var enemyNode = preload("res://Scenes/Maps/EntityNode.tscn")

func createEnemy(name: String, start_node: EntitiyNode) -> Enemy:
	Global.unitsNode.enemyUnits.add_child(start_node)
	var enemy : Enemy = null
	var actions : Array[Action] =  []
	var mini_portrait : String = ""

	var start_health = 0
	match name:
		"Wolf":
			start_health = 50
			mini_portrait = "res://icons/789_Lorc_RPG_icons/Icon.2_11.png"
			enemy = Wolf.new()
		_:
			start_health = 10
			enemy = Enemy.new()
	
	enemy.setup_enemy(name, start_health, Global.tile_map_layer.local_to_map(start_node.position), start_node, mini_portrait)
	Global.tileManager.change_tile_entity(enemy, enemy.location)
	Global.enemies.append(enemy)
	return enemy
