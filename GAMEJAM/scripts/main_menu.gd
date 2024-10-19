extends Node2D

func ready():
	print("weaw")
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://GAMEJAM/Map/Map.tscn")


func _on_quit_pressed() -> void:
	print("AWEWE")
	get_tree().quit()
