class_name RewardHandler

var rewardScreenScene = preload("res://Scenes/Menu/RewardScreens/rewards_screen.tscn")
var rewardItemScene = preload("res://Scenes/Menu/RewardScreens/reward_item.tscn")
var characterSelectload = preload("res://Scenes/Menu/pick_character.tscn")

var card_reward_scene = preload("res://Scenes/Menu/RewardScreens/card_reward_screen.tscn")
var canvas = null
var rewardScreen = null
enum reward_type {card_reward, gold_reward, darksteel_flakes_reward}

func setup(s_canvas : CanvasLayer):
	canvas = s_canvas

func generateRewards() -> RewardScreen:
	rewardScreen = rewardScreenScene.instantiate()
	canvas.add_child(rewardScreen)

	addReward(reward_type.gold_reward)
	addReward(reward_type.darksteel_flakes_reward)
	addReward(reward_type.card_reward)
	return rewardScreen


func addReward(reward : reward_type):
	var rewardItem = rewardItemScene.instantiate()
	rewardScreen.addReward(rewardItem)
	match reward:
		reward_type.card_reward:
			rewardItem.setup(generatePickCardRewardForCharactersBehavior(rewardItem), "Card Reward")
		reward_type.gold_reward:
			var amount = Global.rng.randi_range(40, 60) 
			rewardItem.setup(
				func (): 
					Global.gold_count += amount
					rewardItem.queue_free()
					Global.rewardItemTaken.emit()
					print(Global.gold_count)
					, str(amount, " Gold"))
		reward_type.darksteel_flakes_reward:
			var amount = Global.rng.randi_range(5, 8)
			rewardItem.setup(
				func (): 
					Global.darksteel_flakes += amount
					rewardItem.queue_free()
					Global.rewardItemTaken.emit()
					print(Global.darksteel_flakes)
					, str(amount, " Darksteel Flakes"))
		

func generatePickCardRewardForCharactersBehavior(reward_item: RewardItem) -> Callable:

	return func ():
		var character_screen = characterSelectload.instantiate()
		canvas.add_child(character_screen)
		character_screen.set_behavior(generateCardRewardBehavior(reward_item))
		character_screen.rewardItem = reward_item    

func generateCardRewardBehavior(rewardItem: RewardItem) -> Callable:
	var actions: Array[Action] = []

	for x in range(Global.card_reward_count):
		actions.append(Global.actionFactory.createRandomAction(Global.selected_character))

	return 	func ():
		var card_reward = card_reward_scene.instantiate()
		canvas.add_child(card_reward)
		card_reward.displayActions(actions, rewardItem)
