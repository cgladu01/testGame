class_name HapContainer extends PanelContainer
@onready var rich_text_label: RichTextLabel = $RichTextLabel

var hap : Hap = null

func _ready() -> void:
	pass # Replace with function body.

func set_hap(new_hap: hap):
	hap = new_hap
	rich_text_label.add_text(hap.text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
