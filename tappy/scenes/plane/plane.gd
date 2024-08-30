extends CharacterBody2D

const GRAVITY : float = 600.0
const POWER : float = -200.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	velocity.y += delta * GRAVITY
	fly()
	move_and_slide()
	if is_on_floor():
		die()


func fly() -> void:
	if Input.is_action_just_pressed("fly"):
		velocity.y = POWER
		animation_player.play("power")


func die() -> void:
	set_physics_process(false)
	animated_sprite.stop()
