extends Area2D

const speed: float = 500.0

const PADDLE_POSITION_X_MIN: int = 50
const PADDLE_POSITION_X_MAX: int = 1100

func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		position.x -= speed * delta
		if position.x < PADDLE_POSITION_X_MIN:
			position.x = PADDLE_POSITION_X_MIN
	elif Input.is_action_pressed("right"):
		position.x += speed * delta
		if position.x > PADDLE_POSITION_X_MAX:
			position.x = PADDLE_POSITION_X_MAX
		
