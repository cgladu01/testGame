class_name Action

var name : String = "Unknown"
var owner : Entities
var used : bool = false
var cost : int = 1
var description : String = "Undefined"
var image_path : String = ""
var container : CardContainer = null

signal executed

func setup(owner : Entities):
	self.owner = owner

func setup_placeholder(init_name: String, owner : Entities):
	name = init_name
	setup(owner)


func button_pressed():
	print("Do nothing")

func canPlay():
	if owner is Character:
		var character = owner as Character
		if character.energy - cost < 0:
			return false
		return true

func execute():
	Global.selectionTile.clear()
	if canPlay():
		if owner is Character:
			var character = owner as Character
			character.energy = character.energy - cost

			Global.update_energy.emit(character.energy, character.max_energy)
		
		if container:
			container.onPlay()