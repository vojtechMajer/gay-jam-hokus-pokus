extends CharacterBody2D

@export
var speed = 20

@export
var dash_time := 2
 
var player
var player_estimated_pos
var dashing:bool = false;

@onready var timer_2: Timer = $Timer2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	player = get_tree().get_root().get_node("Map").get_node("Player")


func _physics_process(delta):
	print(player_estimated_pos)
	
	if(dashing):
		position += (player_estimated_pos-Vector2(position.x, position.y)).normalized() * speed * delta

func _on_timer_timeout() -> void:
	player_estimated_pos =+ player.position # + player.velocity
	dashing = true;
	timer_2.start(dash_time)
	animated_sprite_2d.play("attack")


func _on_timer_2_timeout() -> void:
	dashing = false;
	animated_sprite_2d.play("idle")


func _on_animated_sprite_2d_animation_finished() -> void:
	if (dashing):
		animated_sprite_2d.play("roll")
