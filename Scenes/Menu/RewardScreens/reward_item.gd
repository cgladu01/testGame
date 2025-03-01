class_name RewardItem extends HBoxContainer

@onready var label = $"Label"

var behavior : Callable = func(): 
	print("Null Behavior")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func set_behavior(new_behavior : Callable):
	behavior = new_behavior

func setup(new_behavior: Callable, text : String):
	set_behavior(new_behavior)
	set_text(text)

func set_text(text : String):
	label.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_gui_input(event:InputEvent) -> void:
	if event.is_action_pressed("MouseClick"):
		behavior.call()
		queue_free()
