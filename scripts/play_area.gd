extends Node2D

var layer=0
var layers=[]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	layers=[self.get_child(0)]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tile = layers[0].local_to_map(get_global_mouse_position())
	layers[0].set_cell(tile,0,Vector2(0,0),0)



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
