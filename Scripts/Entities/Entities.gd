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

func get_health() -> int:
	return health
	
func set_health(health : int):
	health = health

func change_health(difference : int):
	if difference < 0:
		Global.hapFactory.createLoseHealthHap(-difference, self)

	health += difference
	if health > tot_health:
		health = tot_health
	elif health < 0:
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
				break
		if not exists:
			statuses.append(status)
	else:
		statuses.append(status)

	entityUpdate.emit()

func removeStatus(status: Status):
	var index = 0
	for x in statuses:
		if x.image_path == status.image_path:
			Global.hapFactory.createExpireStatusHap(status, self)
			statuses.remove_at(index)
			break
		index = index + 1

func attack(incomming : int, target: Entities):
	for x in statuses:
		incomming = x.attackEffect(incomming, self, target)
	Global.hapFactory.createAttackHap(incomming, target, self)
	target.attack_damage(incomming, self)

func attack_damage(incoming : int, attacker: Entities):
	var damage = incoming
	for x in statuses:
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
	if path.size() <= distance:
		node.move_along_path(path)
		Global.hapFactory.createMovementHap(self.location, path.back(), self)
		Global.tileManager.move_entity(self, path.back())
	else:
		node.move_along_path(path.slice(0, distance))
		Global.hapFactory.createMovementHap(self.location, path[distance - 1], self)
		Global.tileManager.move_entity(self, path[distance - 1])	

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
