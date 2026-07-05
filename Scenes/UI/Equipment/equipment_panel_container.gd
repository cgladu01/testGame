class_name EquipmentPanelContainer extends PanelContainer

@onready var textureRect: TextureRect = $TextureRect
var equipment: Equipment

func _ready() -> void:
	pass

func setup(set_equipment: Equipment):
	equipment = set_equipment
	textureRect.ready.connect( func (): textureRect.load(equipment.equipment_attributes.spritePath))
 
