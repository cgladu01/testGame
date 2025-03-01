class_name RewardScreen extends PanelContainer

@onready var rewardHolder = $"VBoxContainer/ScrollContainer/RewardsHolder"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func addReward(new_rewardItem : RewardItem):
	rewardHolder.add_child(new_rewardItem)
	