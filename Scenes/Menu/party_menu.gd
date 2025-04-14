extends Control

@onready var partyTalk : Button = $PartyTalk
@onready var rest : Button = $Rest
@onready var hintext : RichTextLabel = $HintLayer
const spacing = 200
const _duration = 0.7
var _tween : Tween

func _ready() -> void:
	partyTalk.position.x = get_viewport().size.x / 2 -(spacing / 2) - partyTalk.size.x
	rest.disabled = Global.rests_available == 0
	rest.position.x = partyTalk.position.x + spacing + partyTalk.size.x
	hintext.position.x = get_viewport().size.x / 2 - (hintext.size.x / 2)
	Global.level_changed.connect(_on_level_changed)

func _on_level_changed():
	queue_free()


func _on_rest_mouse_entered() -> void:
	if _tween:
		_tween.kill()
	hintext.modulate = Color.WHITE
	hintext.clear()
	hintext.append_text(str("All characters heal 30% of total health. ", Global.rests_available, " left available this act."))

func _on_rest_mouse_exited() -> void:
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.tween_property(hintext, "modulate", Color(0, 0, 0, 0), _duration)
	_tween.tween_callback(_done)

func _on_rest_pressed() -> void:
	for character in Global.characters:
		character.perform_rest()
	Global.rests_available -= 1
	rest.disabled = true

func _on_party_talk_mouse_exited() -> void:
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT)
	_tween.tween_property(hintext, "modulate", Color(0, 0, 0, 0), _duration)
	_tween.tween_callback(_done)

func _on_party_talk_pressed() -> void:
	pass # Replace with function body.

func _on_party_talk_mouse_entered() -> void:
	if _tween:
		_tween.kill()
	hintext.modulate = Color.WHITE
	hintext.clear()
	hintext.append_text(str("View available conversations (", Global.available_dialogue, ")."))

func _done() -> void:
	_tween.kill()
	hintext.clear()
