class_name LogContainer extends Control
# Holds all logs and has a scrollable bar to look through the logs

@onready var vbox : VBoxContainer = $VBoxContainer2/VBoxContainer/VBoxContainer
@onready var button: Button = $VBoxContainer2/TitleLine/Expand
@onready var vscroll: ScrollContainer = $VBoxContainer2/VBoxContainer

var drag_position = null
var expanded : bool = false
var SIZECHANGE : int = 400
var haplog = preload("res://Scenes/UI/Logs/HapsLogEntry.tscn")

func gainHap(hap: Hap):
	var hapscene : HapContainer = haplog.instantiate()
	vbox.add_child(hapscene)
	hapscene.set_hap(hap)
	await vscroll.get_v_scroll_bar().changed
	vscroll.scroll_vertical = vscroll.get_v_scroll_bar().max_value 

	
func clearHaps():
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
		self.position = Vector2(self.position.x, 900) if (self.position + Vector2(0, SIZECHANGE)).y > 900 else self.position + Vector2(0, SIZECHANGE)
	else:
		expanded = true
		button.text = "Minimize"
		self.size = self.size  + Vector2(0, SIZECHANGE)
		self.position = Vector2(self.position.x, 10) if (self.position - Vector2(0, SIZECHANGE)).y < 10 else self.position - Vector2(0, SIZECHANGE)


func _on_title_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			drag_position = get_global_mouse_position() - self.position
		else:
			drag_position = null
	if event is InputEventMouseMotion and drag_position:
		self.position = get_global_mouse_position() - drag_position
