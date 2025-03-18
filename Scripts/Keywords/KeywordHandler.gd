class_name KeywordHandler
var tipPanel_load = preload("res://Scenes/UI/Keywords/tip_panel.tscn")
var keywordToDescriptionDict = {
	"Call Of The Abyss" : "Unstackable. Decrements on round start. Take 50 damage when count reaches zero."
	}
var tip_panels = {}

const BUFFFER = Vector2(10, 0)


func removeToolTip(keyword : String):
	if (keyword in tip_panels):
		tip_panels[keyword].queue_free()
		tip_panels.erase(keyword)

func generateToolTip(keyword : String, node: Node):
	var new_tip_panel = tipPanel_load.instantiate()
	Global.canvas_layer.add_child(new_tip_panel)
	print(node.position)
	new_tip_panel.position = node.global_position + Vector2(node.size.x, 0) + BUFFFER
	tip_panels[keyword] = new_tip_panel
	new_tip_panel.setup(keyword, keywordToDescriptionDict.get(keyword))



	
