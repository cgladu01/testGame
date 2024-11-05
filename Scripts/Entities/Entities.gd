class_name Entities

extends "../Tile.gd"

var health : int = 40
var statuses : Array[Status] = []
var name : String = ""

var node : Node2D = null
var miniPortaitPath : String = ""
var spritePath : String = ""
var tot_health : int = 100
var block : int = 0

func get_health() -> int:
	return health
	
func set_health(health : int):
	health = health

func change_health(difference : int):
	health += difference
	if health > tot_health:
		health = tot_health
	elif health < 0:
		health = 0
	Global.update_health.emit()	
	
func setup_entity(start_health : int, start_location : Vector2i, name : String, start_node : UnitNode) -> void:
	tot_health = start_health
	self.name = name
	node = start_node
	setup(start_location)

func addStatus(status: Status):
	var exists = false
	for x in statuses:
		if status.name == x.name:
			x.count += status.count
			exists = true
	if not exists:
		statuses.append(status)

	Global.update_status.emit()

func removeStatus(status: Status):
	var index = 0
	for x in statuses:
		if x.image_path == status.image_path:
			statuses.remove_at(index)
			break
		index = index + 1

func attack_damage(incoming : int, attacker: Entities):
	for x in statuses:
		x.attackEffect(incoming, attacker)
	var damage = incoming - block
	block = block - incoming
	if block < 0:
		block = 0
	change_health(-damage)

func roundStart():
	block = 0
	pass

func roundEnd():
	pass

func _init() -> void:
	pass
