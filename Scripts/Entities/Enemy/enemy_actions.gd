class_name EnemyActions


var enemy_actions_attributes: EnemyActionAttributes = null
var owner: Enemy = null


func setup(owner: Enemy, enemy_actions_attributes: EnemyActionAttributes):
    self.enemy_actions_attributes = enemy_actions_attributes
    self.owner = owner

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

func _get(property: StringName) -> Variant:
    if property in enemy_actions_attributes:
        return enemy_actions_attributes.get(property)
    elif property in self.get_property_list():
        return get(property)
    else:
        return null

func undoPreMove():
    pass