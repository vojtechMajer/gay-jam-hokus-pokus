extends Node2D
class_name PlayerArea

const play_size=29

const GRID_WIDTH := 30
const GRID_HEIGHT := 30

@export var layer_count := 4
@export var tile_set_to_use: TileSet

var selected_layer_id = 3
var layers: Array[TileMapLayer]
func _ready() -> void:
	spawn_layers()
	#layers=[self.get_child(0),self.get_child(1),self.get_child(2),self.get_child(3),self.get_child(4),self.get_child(5)]

func _process(_delta: float) -> void:
	print(selected_layer_id)

	# Scroll Down
	if (Input.is_action_just_released("scroll_down")):
		layers[selected_layer_id].modulate.a8 = 50 #50 255
		if selected_layer_id != 1:
			selected_layer_id -= 1

	# Scroll Up
	if (Input.is_action_just_released("scroll_up")):
		layers[selected_layer_id].modulate.a8 = 255
		if (selected_layer_id != layer_count-1):
			selected_layer_id +=1


func spawn_layers():
	for i in layer_count:
		var new_tile_layer := TileMapLayer.new()
		new_tile_layer.set_tile_set(tile_set_to_use)
		new_tile_layer.name = "layer" + str(i)
		add_child(new_tile_layer)
		layers.append(new_tile_layer)
		## Leave last layer empty
		if i != layer_count-1:
			## (0,0), (-1,-1), ...
			fill_up(new_tile_layer, Vector2i(-i, -i), Vector2i(3,0))


# test funkce
func fill_up(layer: TileMapLayer, start_pos: Vector2i, atlas_coord: Vector2i):
	for x in GRID_WIDTH:
		for y in GRID_HEIGHT:
			layer.set_cell(start_pos + Vector2i(x,y), 0, atlas_coord, 0)


## Input Handling
func _input(event: InputEvent):
	## Place Tile
	if event.is_action_pressed("place_tile"):
		## calculate tilemap position from mouse pos
		var tile_pos = layers[0].local_to_map(get_global_mouse_position()) 
		place_tile(tile_pos, Vector2i(0,0))
	
	
func place_tile(tile_pos: Vector2i, atlas_coords: Vector2i):
	if (tile_pos.x <= play_size-selected_layer_id)&&(tile_pos.y <= play_size-selected_layer_id)&&(tile_pos.x >= 0-selected_layer_id)&&(tile_pos.y >= 0-selected_layer_id):
		layers[selected_layer_id].set_cell(tile_pos,0,atlas_coords,0)
