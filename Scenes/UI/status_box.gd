extends TextureRect
var disp_status : Status = null
@onready var count: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func display_status(status: Status):
	disp_status = status
	self.texture = load(disp_status.image_path)
	count.text = str(disp_status.count)