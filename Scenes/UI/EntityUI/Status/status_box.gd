extends TextureRect
var disp_status : Status = null
@onready var count: Label = $Label
# Displays statuses in a small box

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func display_status(status: Status):
	disp_status = status
	self.texture = load(disp_status.spritePath)
	if disp_status.count != 0:
		count.text = str(disp_status.count)
	else:
		count.text = ""


func _on_mouse_exited() -> void:
	Global.keywordHandler.removeToolTip(disp_status.name)

func _on_mouse_entered() -> void:
	Global.keywordHandler.generateToolTip(disp_status.name, self)
