class_name RewardScreen extends HBoxContainer

@onready var characters : VBoxContainer = $Characters
@onready var rewardPanel : RewardPanels = $RewardPanel
var character_slice_script = preload("res://Scenes/Menu/character_slice.tscn")

func _ready() -> void:
    for character in Global.characters:
        var character_slice_scene = character_slice_script.instantiate()
        character_slice_scene.setup(character)
        characters.add_child(character_slice_scene)

func addReward(new_rewardItem : RewardItem):
    rewardPanel.addReward(new_rewardItem)