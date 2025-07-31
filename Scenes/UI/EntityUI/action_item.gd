class_name ActionItem extends PanelContainer

@onready var value = $VBoxContainer/Value
@onready var image = $VBoxContainer/Image
var image_id = null
var value_id = null


func  _ready() -> void:

	var image_status = Image.new()
	image_status.load(image_id)
	image_status.resize(15, 15)
	var texture = ImageTexture.create_from_image(image_status)
	image.texture = texture
	if value_id != -1:
		value.text = str(value_id)


func setup(image_indicator : String, value_indicator : int):
	value_id = value_indicator
	image_id = image_indicator


	
	
