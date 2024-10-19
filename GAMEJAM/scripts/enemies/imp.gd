extends CharacterBody2D

@export
var speed = 20
@export
var dash_time := 2
@export
var damage := 1

var player
var player_estimated_pos
var dashing:bool = false

@onready var timer_2: Timer = $Timer2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal player_enter_attack_zone

func _ready() -> void:
	player = get_tree().get_root().get_node("Map").get_node("Player")

func _process(delta: float) -> void:
	if (player.position.x > position.x):
		animated_sprite_2d.scale.x = -1;
	else:
		animated_sprite_2d.scale.x = 1;

func _physics_process(delta):
	if(dashing):
		position += (player_estimated_pos-Vector2(position.x, position.y)).normalized() * speed * delta

func _on_timer_timeout() -> void:
	player_estimated_pos = player.position + player.velocity
	dashing = true;
	timer_2.start(dash_time)
	animated_sprite_2d.play("roll")

func _on_timer_2_timeout() -> void:
	dashing = false;
	animated_sprite_2d.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		player_enter_attack_zone.emit()
