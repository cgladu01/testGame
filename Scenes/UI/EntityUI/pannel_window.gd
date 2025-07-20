extends PanelContainer
# When you click on an entity displays an overview in the top right
@onready var title: Label = $VBoxContainer/TitleLine/Title
@onready var mini_portrait: TextureRect = $VBoxContainer/TitleLine/MiniPortrait
@onready var status_line: HBoxContainer = $VBoxContainer/MarginContainer/VBoxContainer/StatusLine
@onready var health_bar: TextureProgressBar = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/HealthBar
@onready var health_text: Label = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Health
var statusBox = preload("res://Scenes/UI/EntityUI/Status/status_box.tscn")

var entity : Entities = null
var drag_position = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_entityDisplay(insert_entity : Entities):
	entity = insert_entity
	title.text = entity.name
	mini_portrait.texture = load(entity.miniPortaitPath)
	mini_portrait.size = Vector2i(70,70)

	fill_status_line()

	health_text.text = str(entity.get_health()) + "/" + str(entity.tot_health)
	health_bar.value = (entity.get_health() as float) / (entity.tot_health) * 100
	if not entity.entityUpdate.is_connected(set_entityDisplay.bind(entity)):
		entity.entityUpdate.connect(set_entityDisplay.bind(entity))

func _update_health():
	health_text.text = str(entity.get_health()) + "/" + str(entity.tot_health)
	health_bar.value = (entity.get_health() as float) / (entity.tot_health) * 100
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			drag_position = get_global_mouse_position() - global_position
		else:
			drag_position = null
	if event is InputEventMouseMotion and drag_position:
		global_position = get_global_mouse_position() - drag_position
		
func _update_status():
	fill_status_line()

func fill_status_line():
	for y in status_line.get_children():
		y.free()
	
	for x in entity.statuses:
		var statusBoxNode = statusBox.instantiate()
		status_line.add_child(statusBoxNode)
		statusBoxNode.display_status(x)

func _on_close_box_pressed() -> void:
	queue_free()
