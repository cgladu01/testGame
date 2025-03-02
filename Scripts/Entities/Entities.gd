class_name Entities

extends "../Tile.gd"

var health : int = 40
var statuses : Array[Status] = []
var name : String = ""

var node : EntitiyNode = null
var miniPortaitPath : String = ""
var spritePath : String = "res://icon.svg"
var tot_health : int = 100
var block : int = 0
signal entityUpdate

# Status Effect Groupings
var onAttackStatuses : Array[Status] = []
var onDefendStatuses : Array[Status] = []
var onGainBlockStatuses : Array[Status] = []
var onNearMovementStatuses : Array[Status] = []
var onMovementStatuses : Array[Status] = []

func get_health() -> int:
	return health
	
func set_health(health : int):
	self.health = health

func change_health(difference : int):
	if difference < 0:
		Global.hapFactory.createLoseHealthHap(-difference, self)

	health += difference
	if health > tot_health:
		health = tot_health
	elif health <= 0:
		health = 0
		if self is Character:
			health = tot_health
			Global.characterDeath.emit()
		else:
			Global.entityDeath.emit()
		
	entityUpdate.emit()

func setup_entity(start_health : int, start_location : Vector2i, name : String, start_node : EntitiyNode) -> void:
	tot_health = start_health
	self.name = name
	if start_node != null:
		node = start_node
		setup(start_location)
		node.set_entity(self)

func addStatus(status: Status, sender: Entities):
	Global.hapFactory.createGiveStatusHap(status, self, sender)
	var exists = false
	if status is not UnStackableStatus:
		for x in statuses:
			if status.name == x.name:
				x.count += status.count
				exists = true
				if status.has_method("moveEffect"):
					addStatusToGrouping(onMovementStatuses, status)
				if status.has_method("nearMoveEffect"):
					addStatusToGrouping(onNearMovementStatuses, status)
				break
		if not exists:
			statuses.append(status)
			if status.has_method("moveEffect"):
				addStatusToGrouping(onMovementStatuses, status)
			if status.has_method("nearMoveEffect"):
				addStatusToGrouping(onNearMovementStatuses, status)
	else:
		statuses.append(status)

	entityUpdate.emit()

func addStatusToGrouping(grouping: Array[Status], new_status: Status):
	var added = false
	if new_status is UnStackableStatus:
		grouping.append(new_status)
	else:
		for status in grouping:
			if status.name == new_status.name:
				status.count += new_status.count
				added = true
	if not added:
		grouping.append(new_status)

func removeStatus(status: Status):
	var index = 0
	for x in statuses:
		if x.image_path == status.image_path:
			Global.hapFactory.createExpireStatusHap(status, self)
			statuses.remove_at(index)
			break
		index = index + 1

func attack(incomming : int, target: Entities):
	for x in onAttackStatuses:
		incomming = x.attackEffect(incomming, self, target)
	Global.hapFactory.createAttackHap(incomming, target, self)

	if target.hasStatus("Under The Sanctuary"):
		for status in target.statuses:
			if status.name == "Under The Sanctuary":
				status.sanctuary_owner.attack_damage(incomming, self)
				return

	target.attack_damage(incomming, self)

func attack_damage(incoming : int, attacker: Entities):
	var damage = incoming
	for x in onDefendStatuses:
		damage = x.deffendEffect(damage, self, attacker)
	var placeholder = damage
	damage = damage - block
	block = block - placeholder

	if block < 0:
		Global.hapFactory.createLoseBlockHap(block + placeholder, self)
		block = 0
	else:
		Global.hapFactory.createLoseBlockHap(placeholder, self)
	change_health(-damage)

func move_on_path(distance: int, path: Array[Vector2i]):
	var og_position = location
	if path.size() <= distance:
		node.move_along_path(path)
		Global.hapFactory.createMovementHap(self.location, path.back(), self)
		Global.tileManager.move_entity(self, path.back())
	else:
		node.move_along_path(path.slice(0, distance))
		Global.hapFactory.createMovementHap(self.location, path[distance - 1], self)
		Global.tileManager.move_entity(self, path[distance - 1])	
	
	for x in onMovementStatuses:
		x.moveEffect(distance)

	if og_position != location:
		Global.moved_entity = self
		Global.entityMoved.emit()
	
func gainBlock(differnce : int):
	block += differnce 

func roundStart():
	block = 0
	for status in statuses:
		status.roundStart()

func changeNode(new_node: EntitiyNode):
	node = new_node
	if node != null:
		setup(Global.tile_map_layer.local_to_map(new_node.position))
		node.set_entity(self)

func hasStatus(status_name: String) -> Status:
	for status in statuses:
		if status.name == status_name:
			return status
	
	return null

func combatStart():
	pass

func roundEnd():
	pass

func _init() -> void:
	pass
