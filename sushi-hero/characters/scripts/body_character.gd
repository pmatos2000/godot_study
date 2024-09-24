extends Node3D
class_name CharacterArmature

const _LERP_VELOCITY: float = 0.10

@export_category("Objects")
@export var _animation_player: AnimationPlayer = null;

func apply_rotation(velocity: Vector3) -> void:
	rotation.y = lerp_angle(
		rotation.y,
		atan(-velocity.x/-velocity.z),
		_LERP_VELOCITY
	)

func animate(velocity: Vector3, running: bool) -> void:
	if velocity:
		if running:
			_animation_player.play("Run")
		else:
			_animation_player.play("Walk")
	else:
		_animation_player.play("Idle")
