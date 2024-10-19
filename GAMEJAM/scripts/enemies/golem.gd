extends CharacterBody2D

@export
var speed = 20
@export
var damage = 2 
var player
var dashing:bool = false;

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var smash_area: Area2D = $Area2D/Smash_area

signal player_enter_attack_zone()

func _ready() -> void:
	player = get_tree().get_root().get_node("Map").get_node("Player")

func _process(delta: float) -> void:
	if (player.position.x > position.x):
		animated_sprite_2d.set_flip_h(true)
	else:
		animated_sprite_2d.set_flip_h(false)


func _physics_process(delta):
	position += (player.position-Vector2(position.x, position.y)).normalized() * speed * delta

func _on_timer_timeout() -> void:
	animated_sprite_2d.play("attack")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		player_enter_attack_zone.emit()
		Global.HP+=-5

func _on_animated_sprite_2d_animation_finished() -> void:
	var bodies = smash_area.get_overlapping_bodies()
	for body in bodies:
		if (body.name == "Player"):
				Global.HP+=-35
				player_enter_attack_zone.emit(damage)
	animated_sprite_2d.play("move")
	
