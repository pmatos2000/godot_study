extends Node3D
class_name CharacterArmature

const _LERP_VELOCITY: float = 0.10

func apply_rotation(velocity: Vector3) -> void:
	rotation.y = lerp_angle(
		rotation.y,
		atan(-velocity.x/-velocity.z),
		_LERP_VELOCITY
	)
