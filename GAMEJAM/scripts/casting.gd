extends Node2D

var Combo=[null,null]
@onready
var map= get_tree().get_root().get_node("Map")
var fire =load("res://GAMEJAM/particles/fireball.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ((Input.is_action_just_pressed("fire"))&&(Global.unlocked[0]==1)):
		Combo[checkOpen()] = 1
	if ((Input.is_action_just_pressed("water"))&&(Global.unlocked[1]==1)):
		Combo[checkOpen()] = 2
	if ((Input.is_action_just_pressed("wind"))&&(Global.unlocked[2]==1)):
		Combo[checkOpen()] = 3
	if ((Input.is_action_just_pressed("lightning"))&&(Global.unlocked[3]==1)):
		Combo[checkOpen()] = 4
	if ((Combo[0] == 1) && (Combo[1] == 1)):
		CastSpell("fireball")
	if ((Combo[0] == 1) && (Combo[1] == 2)):
		CastSpell("fire_water")
	if ((Combo[0] == 1) && (Combo[1] == 3)):
		CastSpell("fire_wind")
	if ((Combo[0] == 1) && (Combo[1] == 4)):
		CastSpell("fire_lighting")
	if ((Combo[0] == 2) && (Combo[1] == 2)):
		CastSpell("water")
	if ((Combo[0] == 2) && (Combo[1] == 3)):
		Combo[0]=null
		Combo[1]=null
	if ((Combo[0] == 2) && (Combo[1] == 4)):
		Combo[0]=null
		Combo[1]=null
	if ((Combo[0] == 3) && (Combo[1] == 3)):
		CastSpell("wind")
	if ((Combo[0] == 3) && (Combo[1] == 4)):
		Combo[0]=null
		Combo[1]=null
	if ((Combo[0] == 4) && (Combo[1] == 4)):
		Combo[0]=null
		Combo[1]=null


func checkOpen():
	if Combo[0]==null:
		return 0
	else:
		return 1


func CastSpell(spellname):
	Combo[0]=null
	Combo[1]=null
	var spell =load("res://GAMEJAM/particles/"+spellname+".tscn").instantiate()
	print(global_position.angle_to(get_global_mouse_position()))
	spell.dir =  (get_angle_to(get_global_mouse_position()))
	spell.spawnPoint = global_position
	spell.rt = rotation
	map.add_child.call_deferred(spell)
