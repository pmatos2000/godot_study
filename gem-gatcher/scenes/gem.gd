extends Area2D

const speed: float = 100.0

func _process(delta: float) -> void:
	position.y += speed * delta
