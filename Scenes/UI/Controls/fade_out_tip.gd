extends PanelContainer


@onready var rich_text : RichTextLabel = $RichTextLabel

const _duration = 1.0
const _delay1 = 0.75
var tip_text = "No tip provided"
var _tween: Tween

func _ready() -> void:
	rich_text.append_text(tip_text)
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.tween_property(self, "modulate", Color(0, 0, 0, 0), _duration).set_delay(_delay1)
	_tween.tween_callback(_done)

func _done() -> void:
	_tween.kill()
	get_viewport().set_input_as_handled()
	queue_free()
