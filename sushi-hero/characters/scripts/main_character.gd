extends CharacterBody3D


const _NORMAL_SPEED: float = 5.0
const _SPRINT_SPEED: float = 9.0

@export_category("Objects")
@export var _body: Node3D = null
@export var _spring_arm_offset: Node3D = null

func _physics_process(delta: float) -> void:
	_move(delta)
	move_and_slide()


func _move(delta: float) -> void:
	var input_direction : Vector2 = Input.get_vector(
		"move_left", "move_right",
		"move_foeward","move_backward"
	)
	
	var direction : Vector3 = transform.basis * Vector3(
		input_direction.x,
		0,
		input_direction.y
	).normalized()
	
	velocity = get_speed() * direction 
	

func get_speed() -> float:
	if Input.is_action_pressed("run"):
		return _SPRINT_SPEED
	return _NORMAL_SPEED
