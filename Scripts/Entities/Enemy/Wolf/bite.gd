class_name Bite extends EnemyActions
const BASE_ATTACK_VALUE = 20
const BASE_MOVE_VALUE = 4

func setup(owner: Enemy):
	add_action_pair("res://icons/789_Lorc_RPG_icons/Icon.1_29.png", BASE_MOVE_VALUE)
	add_action_pair("res://icons/789_Lorc_RPG_icons/Icon.1_55.png", BASE_ATTACK_VALUE)
	name = "Bite"
	super(owner)

func execute():
	var result = Global.enemyMoveEngine.find_closest_player(owner)
	var target = result["target"]
	owner.path = result["path"]
	Global.enemyMoveEngine.do_move_along_path(owner, owner.path, BASE_MOVE_VALUE)
	if Global.tileManager.distance(owner.location, target.location) <= 1:
		owner.attack(20, target)

func attack_values() -> int:
	return BASE_ATTACK_VALUE

func get_target() -> Entities:
	var result = Global.enemyMoveEngine.find_closest_player(owner)
	return result["target"] if result["path"].size() <= BASE_MOVE_VALUE else null
