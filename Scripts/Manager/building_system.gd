extends Node2D
class_name BuildingSystem


@onready var buildable: TileMapLayer = $"../World/buildable"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()



func check_tile():
	return buildable

func _input(event: InputEvent) -> void:
	if event == InputEventScreenTouch and event.is_pressed():
		print("PRESS")
		
