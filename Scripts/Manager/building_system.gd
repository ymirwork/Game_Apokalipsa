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
			
		for x in range(builiding_size.x):
			for y in range(builiding_size.y):
				var old_tile = preview_tile + Vector2i(x,y)
				preview.erase_cell(old_tile)
		# update tile
		preview_tile = value

var scene_tile_building: int = 2 # later adding from Building_Resources
var building_id: int = 1
var builidng_array: Array

var builiding_size: Vector2i = Vector2i(1,1)
@export var temp_scene_building: PackedScene


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
		preview_tile = get_snapped_grid_position(event.position)
		place_building(preview_tile)
		select_mode = false
		

func place_building(top_left_pos: Vector2i):
	var can_place = true
	# Zmiana: Sprawdzenie całego obszaru
	for x in range(builiding_size.x):
		for y in range(builiding_size.y):
			var tile = top_left_pos + Vector2i(x,y)
			print(tile)
			if buildable.get_cell_source_id(tile) != -1: # sprawdzenie zajętości
				can_place = false
				break
			
	if can_place:
		for x in range(builiding_size.x):
			for y in range(builiding_size.y):
				var tile = top_left_pos + Vector2i(x,y)
				var surrounding = buildable.get_surrounding_cells(top_left_pos)
				builidng_array.append(tile)
				print(builidng_array)
				buildable.set_cell(tile, scene_tile_building, Vector2i(0,0), building_id)
				var spawn_building = temp_scene_building.instantiate()
				var building_pos = buildable.map_to_local(top_left_pos)
				spawn_building.position = building_pos
				add_child(spawn_building)
