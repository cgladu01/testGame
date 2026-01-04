extends Control
var card_reward_scene = preload("res://Scenes/Menu/RewardScreens/card_reward_screen.tscn")
@onready var canvas_layer = $"../CanvasLayer"
@onready var playerNodes = $'../Units/PlayerUnits'
@onready var enemyNodes = $'../Units/EnemyUnits'
@onready var camera_2d = $'../Camera2D'
@onready var control = $'../CanvasLayer/Control'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    GDConsole.create_command(kill_all_enemies)
    GDConsole.create_command(generate_card_rewards)
    GDConsole.create_command(give_character_action)
    GDConsole.create_command(reveal_layout)
    GDConsole.create_command(regenerate_layout)
    GDConsole.create_command(trigger_roundStart)
    GDConsole.create_command(give_entity_status)
    GDConsole.create_command(set_character_energy)
    pass # Replace with function body.

func kill_all_enemies():
    while not Global.enemies.is_empty():
        var enemy = Global.enemies.front()
        enemy.set_health(0)
        enemy.change_health(0)
# 
func generate_card_rewards(actionNames_str: String):
    var actionNames = str_to_var(actionNames_str)
    var actions : Array[Action] = []

    for action in actionNames:
        actions.append(Global.actionFactory.createAction(action, Global.characters.front()))
    
    var card_reward = card_reward_scene.instantiate()
    canvas_layer.add_child(card_reward)
    card_reward.displayActions(actions)

func set_character_energy(energy: int, characterName: String):
    for character in Global.characters:
        if character.name == characterName:
            character.energy = energy
            break

func reveal_layout():
    canvas_layer.get_node("LayoutMap").reveal()

func regenerate_layout():
    canvas_layer.get_node("LayoutMap").regnerate_layout()
    canvas_layer.get_node("LayoutMap").reveal()
    
func give_character_action(actionName: String, ownerName: String):
    for character in Global.characters:
        if character.name == ownerName:
            character.hand.addAction(Global.actionFactory.createAction(actionName, character))
            break

func give_entity_status(statusName: String, ownerName: String, count: int):
    print("Giving Status:", statusName, "to", ownerName, "count:", count)
    for entity in Global.characters + Global.enemies:
        if entity.name == ownerName:
            entity.addStatus(Global.statusFactory.createStatus(statusName, count), entity)
            break

func trigger_roundStart(ownerName: String):
    for character in Global.characters:
        if character.name == ownerName:
            character.roundStart()
            break