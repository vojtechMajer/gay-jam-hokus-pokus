extends Node2D

var layer=5
var layers=[]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	layers=[self.get_child(0),self.get_child(1),self.get_child(2),self.get_child(3),self.get_child(4),self.get_child(5)]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var arr =empty_array_3(5,5,5)
	var tile = $TileMapLayer6.local_to_map(get_global_mouse_position())
	if (Input.is_action_just_released("scrollUp")):
		if (layer!=1):
			layers[layer].modulate.a8=50
			layer-=1
	if (Input.is_action_just_released("scrollDown")):
		if (layer!=5):
			layer+=1
			layers[layer].modulate.a8=255
	if(Input.is_action_pressed("rightClick")):
		if (tile.x <= 30-layer)&&(tile.y <= 30-layer)&&(tile.x >= 0-layer)&&(tile.y >= 0-layer):
			layers[layer].set_cell(tile,3,Vector2(0,0),0)
	if(Input.is_action_pressed("leftClick")):
		if (tile.x <= 30-layer)&&(tile.y <= 30-layer)&&(tile.x >= 0-layer)&&(tile.y >= 0-layer):
			layers[layer].set_cell(tile,3,Vector2(0,1),0)


func empty_array_3(size_x: int, size_y: int, size_z: int, contents = 0) -> Array:
	var inner: = []
	inner.resize(size_z)
	inner.fill(contents)
	
	var mid: = []
	mid.resize(size_y)
	for y in size_y:
		mid[y] = inner.duplicate()
	
	var outer: = []
	outer.resize(size_x)
	for x in size_x:
		outer[x] = mid.duplicate()
	return outer
