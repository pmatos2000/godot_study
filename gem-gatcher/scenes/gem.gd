extends Area2D

const speed: float = 100.0

func _process(delta: float) -> void:
	position.y += speed * delta
	
	if position.y > get_viewport_rect().size.y:
		set_process(false)
		queue_free()
