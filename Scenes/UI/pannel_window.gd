extends PanelContainer
@onready var title: Label = $VBoxContainer/TitleLine/Title
@onready var mini_portrait: TextureRect = $VBoxContainer/TitleLine/MiniPortrait
@onready var status_line: HBoxContainer = $VBoxContainer/MarginContainer/VBoxContainer/StatusLine
@onready var health_bar: TextureProgressBar = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/HealthBar
@onready var health_text: Label = $VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Health

var entity : Entities = null
var drag_position = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.update_health.connect(_update_health)
	Global.update_status.connect(_update_status)
	pass # Replace with function body.

func set_entityDisplay(insert_entity : Entities):
	entity = insert_entity
	title.text = entity.name
	var image = Image.new()
	image.load(entity.miniPortaitPath)
	image.resize(30, 30)
	mini_portrait.texture = ImageTexture.create_from_image(image)

	fill_status_line()

	health_text.text = str(entity.get_health()) + "/" + str(entity.tot_health)
	health_bar.value = (entity.get_health() as float) / (entity.tot_health) * 100

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
		var image_status = Image.new()
		image_status.load(x.image_path)
		image_status.resize(20, 20)
		var textureRect = TextureRect.new()
		textureRect.texture = ImageTexture.create_from_image(image_status)
		status_line.add_child(textureRect)

func _on_close_box_pressed() -> void:
	queue_free()
