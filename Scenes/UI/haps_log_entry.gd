class_name HapContainer extends PanelContainer
@onready var rich_text_label: Label = $RichTextLabel

var hap : Hap = null

func _ready() -> void:
	pass # Replace with function body.

func set_hap(new_hap: Hap):
	hap = new_hap
	rich_text_label.text = hap.description

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
