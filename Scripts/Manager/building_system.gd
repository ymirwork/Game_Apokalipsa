extends Node2D
class_name Building_System


@onready var buildable: TileMapLayer = $"../World/Buildable"
@onready var preview: TileMapLayer = $"../World/Preview"

var source_id : int
var selected_tile: Vector2i
var select_mode: bool = false
var preview_tile: Vector2i:
	set(value):
		if preview_tile == value:
			return
		preview.erase_cell(preview_tile)
		preview_tile = value
		preview.set_cell(value, scene_tile_building, Vector2i(0,0),building_id)

var scene_tile_building: int = 2 # later adding from Building_Resources
var building_id: int = 1


func get_snapped_grid_position(pos: Vector2) -> Vector2i:
	var local_pos = buildable.to_local(pos)
	var tile_pos = buildable.local_to_map(local_pos)
	return tile_pos

func _input(event: InputEvent) -> void:
	#PC DEBUG
	if event is InputEventKey:
		if event.keycode == KEY_1 and event.pressed: # Clicked 1 to active building for debug. #Later add UI
			select_mode = true
	
	if event is InputEventScreenTouch and event.is_pressed() and select_mode:
		if select_mode:
			preview_tile = get_snapped_grid_position(event.position)
			print(preview_tile)
			place_building(preview_tile)
			select_mode = false
		

func place_building(building_pos: Vector2i):
	buildable.set_cell(building_pos, scene_tile_building, Vector2i(0,0),building_id)
	preview.erase_cell(building_pos)
