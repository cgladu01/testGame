class_name RewardScreen extends HBoxContainer

@onready var characters : VBoxContainer = $Characters
@onready var rewardPanel : RewardPanels = $RewardPanel
var character_slice_script = preload("res://Scenes/Menu/character_slice.tscn")

func _ready() -> void:
    Global.rewardItemTaken.connect(_on_RewardTaken)
    Global.toggle_map.connect(_on_map_toggle)
    for character in Global.characters:
        var character_slice_scene = character_slice_script.instantiate()
        character_slice_scene.setup(character)
        characters.add_child(character_slice_scene)

func addReward(new_rewardItem : RewardItem):
    rewardPanel.addReward(new_rewardItem)

func _on_RewardTaken():
    for child in get_children():
        if child is RewardPanels:
            if child.is_queued_for_deletion():
                queue_free()

func _on_map_toggle():
    self.visible = false