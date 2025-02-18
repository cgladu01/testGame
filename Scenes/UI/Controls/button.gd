extends Button
signal EndTurnPlayerTurn
@onready var canvas_layer : CanvasLayer = $"../../../../../"
var scene = preload("res://Scenes/UI/Controls/EndTurn.tscn")
var window = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(self._button_pressed)
	pass


func _button_pressed():
	window = scene.instantiate()
	canvas_layer.add_child(window)
	Global.selectionTile.clear()
	window.recieve_signal(EndTurnPlayerTurn)


	
