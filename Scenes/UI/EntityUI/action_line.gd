class_name ActionLine extends HBoxContainer
var enemy:Enemy = null
const ACTION_LINE_SPACING = Vector2(0, -10)
var preload_action_items = preload("res://Scenes/UI/EntityUI/action_item.tscn")
# Dipslays enemy intents

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	await get_tree().process_frame
	await get_tree().process_frame
	visible = true
	self.position = self.position - Vector2(self.size.x/2, self.size.y) + ACTION_LINE_SPACING

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_enemy(new_enemy: Enemy) -> void:
	enemy = new_enemy

func update_actions():
	for child in get_children():
		child.queue_free()

	for x in len(enemy.action.imageIndicator):
			var action_item = preload_action_items.instantiate()
			action_item.setup(enemy.action.imageIndicator[x], enemy.action.numberIndicators[x])
			self.add_child(action_item)

