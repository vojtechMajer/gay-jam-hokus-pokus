extends Node
class_name GridManager

@onready var ground: TileMapLayer = $TileMap/Ground

static var GRID_WIDTH = 10
static var GRID_HEIGHT = 10

func _ready() -> void:
	## returns id of tile set resource which will be used, in this case the first one
	var ground_tile_set_id = ground.tile_set.get_source_id(0)
	
	## spawns GRID_WIDTH by GRID_HEIGHT grid of default tiles
	for x in GRID_WIDTH:
		for y in GRID_HEIGHT:
			ground.set_cell(Vector2i(x,y), ground_tile_set_id, Vector2i(0,0), 0 )
