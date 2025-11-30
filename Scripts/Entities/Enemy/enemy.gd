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

	if damage != -1:
		pass
	for status in inc_statuses:
		pass
	
	show_targeting()

func show_targeting(real_location: bool = true):
	var target = action.get_target(real_location)

	for child in self.node.get_children():
		if child is Arrow:
			child.queue_free()
			
	if target:
		var arrow = Arrow.new()		
		arrow.head_length = 8
		arrow.stem_width = 2
		arrow.head_width = 10
		arrow.corner_radius = 0
		arrow.target = Global.selectionTile.map_to_local(
			target.location if real_location else Global.get_mock_location(target)) - self.node.global_position
		arrow.fill_color = Color.DARK_RED
		self.node.add_child(arrow)

func undoPreMove():
	action.undoPreMove()
	for x in self.node.get_children():
		if x is Arrow:
			x.queue_free()

func _init() -> void:
	pass
