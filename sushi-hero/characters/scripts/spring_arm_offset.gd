extends Node3D
class_name SpringArmOffset

const _MOUSE_SENSIBILITY : float  = 0.003
const _JOYSTICK_SENSIBILITY : float = 0.03

const _ROTATION_SPRING_X_MIN = -PI/4
const _ROTATION_SPRING_X_MAX = PI/24


@export_category("Objects")
@export var spring_arm: SpringArm3D = null


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * _MOUSE_SENSIBILITY) 
		spring_arm.rotate_x(-event.relative.y * _MOUSE_SENSIBILITY)
		_clamp_limits_rotate()


func _physics_process(_delta: float) -> void:
	var new_rotate : Vector2 = Input.get_vector(
		"rotate_cam_left", "rotate_cam_right",
		"rotate_cam_down", "rotate_cam_up",
	)
	rotate_y(new_rotate.x * _JOYSTICK_SENSIBILITY)
	spring_arm.rotate_x(new_rotate.y * _JOYSTICK_SENSIBILITY)
	_clamp_limits_rotate()


func _clamp_limits_rotate() -> void:
	spring_arm.rotation.x = clamp(
		spring_arm.rotation.x,
		_ROTATION_SPRING_X_MIN,
		_ROTATION_SPRING_X_MAX
	)
