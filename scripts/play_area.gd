extends Node2D
const playSize=30
var layer=4
var layers=[]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	layers=[self.get_child(0),self.get_child(1),self.get_child(2),self.get_child(3),self.get_child(4),self.get_child(5)]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tile = layers[0].local_to_map(get_global_mouse_position())
	if (Input.is_action_just_released("scrollUp")):
		if (layer!=1):
			layers[layer].modulate.a8=50
			layer-=1
	if (Input.is_action_just_released("scrollDown")):
		if (layer!=5):
			layer+=1
			layers[layer].modulate.a8=255

func _input(event: InputEvent):
	var tile = layers[0].local_to_map(event.position)
	if event.is_action_pressed("place_tile"):
		if (tile.x <= playSize-layer)&&(tile.y <= playSize-layer)&&(tile.x >= 0-layer)&&(tile.y >= 0-layer):
			layers[layer].set_cell(tile,0,Vector2(0,0),0)
