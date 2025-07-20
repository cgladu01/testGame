class_name KeywordHandler
var tipPanel_load = preload("res://Scenes/UI/Keywords/tip_panel.tscn")
var keywordToDescriptionDict = {
	"Call Of The Abyss" : "Unstackable. Decrements on round start. Take 50 damage when count reaches zero.",
	"Daze" : "Prevents passive defensive buffs from activating. Decrements on round end and hit.",
	"Bleed" : "On unblocked attack damage, take damage equal to stacks. Halved at round end.",
	"Sanctuary": "Redirects attack damge to self to allies within range. Range is equal to count. Removed at round start.",
	"Under The Sanctuary" : "Attack damage recieved is redirected to ally with [url=Sanctuary]Sanctuary[/url]",
	"Strength" : "Increases attack damage by count.",
	"Silence" : "Cannot play skills. Decrements on round end.",
	"Bud" : "Decrements on round start. When it reaches zero gain [url=Flower]Flower[/url]",
	"Flower": "Attacks deal 10% * stack more damage and Blocks gain 10% * stack more block."
	}
var tip_panels = []

const BUFFFER = Vector2(10, 0)
const SEPERATOR = Vector2(0, 10)


func removeToolTip(keyword : String):
	if not keywordToDescriptionDict.has(keyword):
		return
	var index = 0
	for tip_panel in tip_panels:
		if tip_panel.keywordName.text == keyword:
			tip_panel.queue_free()
			tip_panels.remove_at(index)
		index = index + 1

func generateToolTip(keyword : String, node: Node):
	if not keywordToDescriptionDict.has(keyword):
		return
	var new_tip_panel = tipPanel_load.instantiate()
	Global.canvas_layer.add_child(new_tip_panel)
	if tip_panels.is_empty():
		new_tip_panel.position = node.global_position + Vector2(node.size.x, 0) + BUFFFER
		if new_tip_panel.position.x + new_tip_panel.size.x >= node.get_viewport().size.x + node.get_viewport().position.x:
				new_tip_panel.position = Vector2(node.get_viewport().size.x + node.get_viewport().position.x - new_tip_panel.size.x, node.global_position.y + node.size.y) - BUFFFER + SEPERATOR
	else:		
		new_tip_panel.position = tip_panels.back().position + Vector2(0, tip_panels.back().size.y) + SEPERATOR
	tip_panels.append(new_tip_panel)
	new_tip_panel.setup(keyword, keywordToDescriptionDict.get(keyword))



	
