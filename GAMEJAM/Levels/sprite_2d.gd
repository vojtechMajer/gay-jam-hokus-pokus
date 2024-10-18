extends Sprite2D
var sizeOfLevel : Vector2i
@export
var allRuins: Array[Sprite2D]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Velikost mapy
	sizeOfLevel = Vector2i(47*32,32*32)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func createPositionOfRuins():
	var kvadranty = [0,0,0,0]
	
	var random = randi_range(0,3)
