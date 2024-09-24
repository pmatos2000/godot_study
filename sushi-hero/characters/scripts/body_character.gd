extends Node3D
class_name Body

const _LERP_VELOCITY: float = 0.15

func apply_rotation(velocity: Vector3) -> void:
	rotation.y = lerp(
		rotation.y,
		atan(-velocity.x/-velocity.z),
		_LERP_VELOCITY
	)
