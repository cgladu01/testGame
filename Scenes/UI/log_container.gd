class_name  Log_Container extends Control
@onready var vbox : VBoxContainer = $VBoxContainer
@onready var button: Button = $VBoxContainer/TitleLine/Expand

var drag_position = null
var expanded : bool = false
var SIZECHANGE : int = 400
var hapScene = preload("res://Scenes/UI/HapsLogEntry.tscn")

func gainHap(hap : Hap):
	var hapLogEntry : HapContainer = hapScene.instantiate()
	vbox.add_child(hapLogEntry)
	hapLogEntry.set_hap(hap)


func clearHap():
	for child in vbox.get_children():
		if child is HapContainer:
			child.queue_free()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_expand_pressed() -> void:
	if expanded:
		expanded = false
		button.text = "Expand"
		self.size = self.size + Vector2(0, -SIZECHANGE)
		self.position = self.position + Vector2(0, SIZECHANGE)
	else:
		expanded = true
		button.text = "Minimize"
		self.size = self.size  + Vector2(0, SIZECHANGE)
		self.position = self.position - Vector2(0, SIZECHANGE)


func _on_title_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			drag_position = get_global_mouse_position() - self.position
		else:
			drag_position = null
	if event is InputEventMouseMotion and drag_position:
		self.position = get_global_mouse_position() - drag_position