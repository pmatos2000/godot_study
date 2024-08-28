extends Node2D

@export var gen_scene : PackedScene

const GEN_POSITION_INIT_Y: float = -50.0
const GEN_POSITION_INIT_X_MIN: float = 70.0
const GEN_POSITION_INIT_X_MAX: float = 1050.0

func spawn_gen() -> void:
	var new_gen: Gen = gen_scene.instantiate()
	new_gen.on_gen_off_screen.connect(game_over)
	var pos_init_x = randf_range(GEN_POSITION_INIT_X_MIN, GEN_POSITION_INIT_X_MAX)
	new_gen.position = Vector2(pos_init_x, GEN_POSITION_INIT_Y)
	add_child(new_gen)

func game_over() -> void:
	print("game_over")
