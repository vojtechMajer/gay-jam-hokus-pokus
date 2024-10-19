extends Node2D

var sizeOfLevel : Vector2i
@export var ruins: Array[Sprite2D]

# Velikost pro náhodné umístění uvnitř kvadrantu
const OFFSET = 128

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Nastav velikost mapy
	sizeOfLevel = Vector2i(47*32,32*32)
	createPositionOfRuins()

# Vytvoření pozic ruin
func createPositionOfRuins():
	# Definice kvadrantů
	var quadrant_acceptation = [0,0,0,0]
	var quadrants = [
		Rect2(Vector2(0, 0), sizeOfLevel / 2),  # horní levý
		Rect2(Vector2(sizeOfLevel.x / 2, 0), sizeOfLevel / 2),  # horní pravý
		Rect2(Vector2(0, sizeOfLevel.y / 2), sizeOfLevel / 2),  # dolní levý
		Rect2(Vector2(sizeOfLevel.x / 2, sizeOfLevel.y / 2), sizeOfLevel / 2)  # dolní pravý
	]
	# Pro každý sprite v allRuins
	for sprite in ruins:
		
		# Náhodně vyber kvadrant
		var random_index = randi_range(0, 3)
		var selected_quadrant
		while (quadrant_acceptation[random_index]==1): 
			random_index = randi_range(0, 3)
		selected_quadrant = quadrants[random_index]
		# Generuj náhodnou pozici uvnitř kvadrantu s offsetem
		var random_position = Vector2(
			randi_range(selected_quadrant.position.x + OFFSET, selected_quadrant.position.x + selected_quadrant.size.x - OFFSET),
			randi_range(selected_quadrant.position.y + OFFSET, selected_quadrant.position.y + selected_quadrant.size.y - OFFSET)
		)
			# Nastav pozici sprite
		quadrant_acceptation[random_index]=1
		sprite.position = random_position
