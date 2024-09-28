extends Panel


signal chose(tileset_posision)
@export var cords: Vector2i = Vector2i(-1,-1)


func _gui_input(event):
	if event.is_action_pressed("right_click"):
		emit_signal("chose",cords)
