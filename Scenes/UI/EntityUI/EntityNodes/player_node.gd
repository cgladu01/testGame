class_name CharacterNode extends EntitiyNode
var character: Character
var characterNum: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_character(character: Character):
	set_entity(character)
	self.character = character


func refresh_Actions():
	pass
