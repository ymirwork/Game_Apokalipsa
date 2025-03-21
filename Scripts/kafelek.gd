extends Node2D


var position_kafelek:
	set(value):
		value = position
	get:
		return position
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index += position_kafelek.y
	#print("Kafelek:", position_kafelek, "Index Z : ", z_index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch and event.is_pressed():
		print("TOUCH: ", event.position)
		
