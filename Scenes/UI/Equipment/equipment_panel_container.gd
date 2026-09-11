class_name EquipmentPanelContainer extends PanelContainer

@onready var textureRect: TextureRect = $TextureRect
var equipment: Equipment

func _ready() -> void:
	pass

func setup(set_equipment: Equipment):
	equipment = set_equipment
	textureRect.texture = load(equipment.equipment_attributes.spritePath)
	textureRect.size = Vector2i(30,30)
 
