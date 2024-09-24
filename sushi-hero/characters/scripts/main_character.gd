extends CharacterBody3D


const _NORMAL_SPEED: float = 5.0
const _SPRINT_SPEED: float = 9.0

@export_category("Objects")
@export var _body: CharacterArmature = null
@export var _spring_arm_offset: Node3D = null


func _physics_process(_delta: float) -> void:
	_move()
	move_and_slide()
	_body.animate(velocity, is_running())


func _move() -> void:
	var input_direction : Vector2 = Input.get_vector(
		"move_left", "move_right",
		"move_foeward","move_backward"
	)
	
	var direction : Vector3 = transform.basis * Vector3(
		input_direction.x,
		0,
		input_direction.y
	).normalized()
	
	direction = direction.rotated(Vector3.UP, _spring_arm_offset.rotation.y)
	
	var speed : float = _get_speed();
	
	if direction:
		velocity = speed * direction
		_body.apply_rotation(direction)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, speed) 


func is_running() -> bool:
	return Input.is_action_pressed("run")


func _get_speed() -> float:
	if is_running():
		return _SPRINT_SPEED
	return _NORMAL_SPEED
