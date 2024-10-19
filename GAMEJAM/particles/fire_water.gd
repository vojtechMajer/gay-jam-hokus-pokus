extends Area2D

@export 
var SPEED = 4


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
	self.get_child(2).emitting=false
	self.get_child(3).emitting=true
	self.get_child(0).disabled=true
	self.get_child(1).disabled=false
	




func _on_body_entered(body: Node2D) -> void:
	print("hit")
	self.get_child(2).emitting=false
	self.get_child(3).emitting=true
	self.get_child(0).disabled=true
	self.get_child(1).disabled=false
	$Timer2.start()


func _on_timer_2_timeout() -> void:
	self.queue_free()
