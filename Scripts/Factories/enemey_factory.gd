class_name EnemyFactory

var enemyNode = preload("res://Scenes/UI/EntityUI/EntityNodes/entitity_node.gd")

func createEnemy(name: String, start_node: EntitiyNode) -> Enemy:
	Global.unitsNode.enemyUnits.add_child(start_node)
	var enemy : Enemy = null
	var enemy_attributes = null

	var start_health = 0
	match name:
		"Wolf":
			start_health = 50
			enemy = Wolf.new()
			enemy_attributes = load("res://Resources/Entities/Enemy/Wolf/wolf.tres")
		_:
			start_health = 10
			enemy = Enemy.new()

	enemy.setup_enemy(start_health, Global.tile_map_layer.local_to_map(start_node.position), start_node, enemy_attributes)
	Global.tileManager.change_tile_entity(enemy, enemy.location)
	Global.enemies.append(enemy)
	return enemy
