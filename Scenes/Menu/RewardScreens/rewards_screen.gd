class_name RewardScreen extends PanelContainer

@onready var rewardHolder = $"VBoxContainer/ScrollContainer/RewardsHolder"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.rewardItemTaken.connect(_on_RewardTaken)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func addReward(new_rewardItem : RewardItem):
	rewardHolder.add_child(new_rewardItem)

func _on_RewardTaken():
	var delete = true
	for child in rewardHolder.get_children():
		if not child.is_queued_for_deletion():
			delete = false
			break

	if delete:
		queue_free()