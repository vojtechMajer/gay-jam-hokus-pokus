extends Node

var sizeOfLevel : Vector2i
@export var ruuins: Array[Sprite2D]
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
	for sprite in ruuins:
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


func _on_water_area_body_entered(body: CharacterBody2D) -> void:
	#array začíná od nuly, water je indikováná normálně jako 2
	if(body.name=="Player"):
		Global.unlocked[2-1]=1

func _on_fire_area_body_entered(body: CharacterBody2D) -> void:
	if(body.name=="Player"):
		Global.unlocked[1-1]=1


func _on_lighting_area_body_entered(body: CharacterBody2D) -> void:
	if(body.name=="Player"):
		Global.unlocked[4-1]=1



func _on_wind_area_body_entered(body: CharacterBody2D) -> void:
	if(body.name=="Player"):
		Global.unlocked[3-1]=1
