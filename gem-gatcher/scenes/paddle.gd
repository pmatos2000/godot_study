extends Area2D

const speed: float = 100.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("right"):
		position.x += speed * delta

func _on_gem_area_entered(area: Area2D) -> void:
	print(area)
