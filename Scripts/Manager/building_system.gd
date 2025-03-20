extends Node2D
class_name BuildingSystem


@onready var buildable: TileMapLayer = $"../World/buildable"
var selected_tile: int = 1 # Defualt none tile
var is_building: bool = false
var tile_array: Array


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func select_building(tile_id: int):
	selected_tile = tile_id
	is_building = true
	
func can_build_tile(cell_position: Vector2i):
	if selected_tile != -1:
		buildable.set_cell(cell_position, 2, Vector2i(0,0),1)
		print(buildable.get_surrounding_cells(cell_position))
		
		

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.is_pressed():
		var position_tile = event.position
		var cell_pos = buildable.local_to_map(position_tile)
		
		
		if can_build_tile(cell_pos):
			#print(buildable.get_surrounding_cells(cell_pos))
			pass
		
