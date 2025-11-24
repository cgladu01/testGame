class_name EnemyActions

var imageIndicator: Array[String] = []
var numberIndicators: Array[int] = []
var owner: Enemy = null
var name: String = ""


func setup(owner: Enemy):
    self.owner = owner

func add_action_pair(image_path: String, value: int):
    imageIndicator.append(image_path)
    numberIndicators.append(value)

func execute():
    pass

func attack_values() -> int:
    return -1

func statuses() -> Array[Status]:
    return []

func get_target(real_location: bool = true) -> Entities:
    return null

func doPreMove():
    pass

func undoPreMove():
    pass