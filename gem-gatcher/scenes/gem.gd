extends Area2D

class_name Gen

const speed: float = 100.0

signal on_gen_off_screen()

func _process(delta: float) -> void:
	position.y += speed * delta
	
	if position.y > get_viewport_rect().size.y:
		on_gen_off_screen.emit()
		Util.remove_node(self)
