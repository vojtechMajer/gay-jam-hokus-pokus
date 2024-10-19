extends Area2D

@export 
var SPEED = 10

var dir :float
var rt :float
var spawnPoint : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position=spawnPoint
	global_rotation=rt
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(SPEED,0).rotated(dir)


func _on_timer_timeout() -> void:
	self.queue_free()



func _on_body_entered(body: Node2D) -> void:
	print("hit")
	self.get_child(1).emitting=false
