class_name Bite extends EnemyActions
const BASE_ATTACK_VALUE = 1
const BASE_MOVE_VALUE = 0


func execute():
	var result = Global.enemyMoveEngine.find_closest_player(owner)
	var target = result["target"]
	owner.path = result["path"]
	Global.enemyMoveEngine.do_move_along_path(owner, owner.path,  self.numberIndicators[BASE_MOVE_VALUE])
	if Global.tileManager.distance(owner.location, target.location) <= 1:
		owner.attack(self.numberIndicators[BASE_ATTACK_VALUE], target)

func attack_values() -> int:
	return BASE_ATTACK_VALUE

func get_target(real_location: bool = true) -> Entities:
	var result = Global.enemyMoveEngine.find_closest_player(owner, real_location)
	return result["target"] if result["path"].size() <= self.numberIndicators[BASE_MOVE_VALUE] else null
