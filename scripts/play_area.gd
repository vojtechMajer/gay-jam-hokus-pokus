extends Node2D

@export var grid_width := 30
@export var grid_height := 30
@export var layer_count := 4
@export var tile_set_to_use: TileSet
@export var ground_level_atlas_coords: Array[Vector2i]
var placehorder_cursor:= [load("res://sprites/placeholder-tile.png"),load("res://sprites/placeholder-tile-mright.png"),load("res://sprites/placeholder-tile-mleft.png"),load("res://sprites/placeholder-tile-top.png")]
var active_layer_id
var layers: Array[TileMapLayer]
@onready var placeholder_tile: Sprite2D = $PlaceholderTile



func _ready() -> void:
	## Set top layer as initial layer
	active_layer_id = layer_count-1
	spawn_layers()

func _process(_delta: float) -> void:
	## Scroll Down
	if (Input.is_action_just_released("scroll_down")):
		if active_layer_id != 1:
			layers[active_layer_id].modulate.a8 = 50
			active_layer_id -= 1

	## Scroll Up
	if (Input.is_action_just_released("scroll_up")):
		if (active_layer_id != layer_count-1):
			layers[active_layer_id+1].modulate.a8 = 255
			active_layer_id += 1

	## Move Placeholder Tile

func spawn_layers():
	for i in layer_count:
		var new_tile_layer := TileMapLayer.new()
		new_tile_layer.set_tile_set(tile_set_to_use)
		new_tile_layer.name = "layer" + str(i)
		add_child(new_tile_layer)
		layers.append(new_tile_layer)
		## Leave last layer empty (for buildings slots)
		if i != layer_count-1:
			## (0,0), (-1,-1), ...
			fill_up(new_tile_layer, Vector2i(-i, -i), ground_level_atlas_coords[i])

# test funkce
func fill_up(layer: TileMapLayer, start_pos: Vector2i, atlas_coord: Vector2i):
	for x in grid_width:
		for y in grid_height:
			layer.set_cell(start_pos + Vector2i(x,y), 0, atlas_coord, 0)

## Input Handling
#func _input(event: InputEvent):
	###placeholder_cursor
	#cursor_state()
	### Place Tile
	#if event.is_action_pressed("place_tile"):
		### calculate tilemap position from mouse pos
		#var tile_pos = layers[0].local_to_map(get_global_mouse_position()) 
		#place_tile(tile_pos, Vector2i(0,0))

func cursor_state():
	var state=0
	var placeholder_pos := layers[active_layer_id].map_to_local(layers[active_layer_id].local_to_map(get_global_mouse_position())) #layers[0].local_to_map(get_global_mouse_position())
	placeholder_tile.set_position(placeholder_pos)
	if(layers[active_layer_id].get_cell_atlas_coords(layers[active_layer_id].local_to_map(placeholder_pos)+Vector2i(1,0))!=Vector2i(-1,-1)):
		state+=1
	if(layers[active_layer_id].get_cell_atlas_coords(layers[active_layer_id].local_to_map(placeholder_pos)+Vector2i(0,1))!=Vector2i(-1,-1)):
		state+=2
	placeholder_tile.texture =placehorder_cursor[state]

func place_tile(tile_pos: Vector2i, atlas_coords: Vector2i):
	if (tile_pos.x <= grid_width-1-active_layer_id)&&(tile_pos.y <= grid_height-1-active_layer_id)&&(tile_pos.x >= 0-active_layer_id)&&(tile_pos.y >= 0-active_layer_id):
		layers[active_layer_id].set_cell(tile_pos,0,atlas_coords,0)
