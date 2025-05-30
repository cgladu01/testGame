class_name Enemy extends Entities
var performed_actions : Array[EnemyActions] = []
var turn_actions : Array[EnemyActions] = []
var action: EnemyActions = null
var path : Array[Vector2i]

func get_actions() -> Array[EnemyActions]:
	return turn_actions

# Pick turn from set of actions
# Must implement the actual picking in subclasses
func setup_turn():
	if node != null and node.actionLine != null:
		node.dispActionline()
	pass

func setup_enemy(init_name : String, start_health : int, start_location : Vector2i, start_node : EntitiyNode, mini_portrait_path : String) -> void:
	name = init_name
	turn_actions = []
	miniPortaitPath = mini_portrait_path
	setup_entity(start_health, start_location, init_name, start_node)

func do_Turn():
	action.execute()
	pass

func doPreMove():
	action.doPreMove()
	var damage = action.attack_values()
	var inc_statuses = action.statuses()
	var target = action.get_target()

	if damage != -1:
		pass
	for status in inc_statuses:
		pass
	if target:
		var arrow = Arrow.new()
		arrow.target = target.node.global_position - self.node.global_position
		arrow.head_length = 20
		arrow.stem_width = 2
		arrow.head_width = 15
		arrow.corner_radius = 0
		self.node.add_child(arrow)

func undoPreMove():
	action.undoPreMove()
	for x in self.node.get_children():
		if x is Arrow:
			x.queue_free()

func _init() -> void:
	pass
