class_name RewardHandler

var rewardScreenScene = preload("res://Scenes/Menu/RewardScreens/rewards_screen.tscn")
var rewardItemScene = preload("res://Scenes/Menu/RewardScreens/reward_item.tscn")
var characterSelectload = preload("res://Scenes/Menu/pick_character.tscn")

var card_reward_scene = preload("res://Scenes/Menu/RewardScreens/card_reward_screen.tscn")
var canvas = null

func setup(s_canvas : CanvasLayer):
	canvas = s_canvas

func generateRewards() -> RewardScreen:
	var rewardScreen = rewardScreenScene.instantiate()
	var rewardItem = rewardItemScene.instantiate()
	canvas.add_child(rewardScreen)
	rewardScreen.addReward(rewardItem)
	rewardItem.setup(generatePickCardRewardForCharactersBehavior(rewardItem), "Card Reward")
	return rewardScreen


func generatePickCardRewardForCharactersBehavior(reward_item: RewardItem) -> Callable:

	return func ():
		var character_screen = characterSelectload.instantiate()
		canvas.add_child(character_screen)
		character_screen.set_behavior(generateCardRewardBehavior())
		character_screen.rewardItem = reward_item    

func generateCardRewardBehavior() -> Callable:
	var actions: Array[Action] = []

	for x in range(Global.card_reward_count):
		actions.append(Global.actionFactory.createRandomAction(Global.selected_character))

	return 	func ():
		var card_reward = card_reward_scene.instantiate()
		canvas.add_child(card_reward)
		card_reward.displayActions(actions)
