class_name EnemyActions

var imageIndicator: Array[String] = []
var numberIndicators: Array[int] = []
var owner: Enemy = null
var name: String = ""


func setup(owner: Enemy):
    self.owner = owner

func execute():
    pass

func attack_values() -> int:
    return -1

func statuses() -> Array[Status]:
    return []

func get_target() -> Entities:
    return null

func doPreMove():
    pass

func undoPreMove():
    pass