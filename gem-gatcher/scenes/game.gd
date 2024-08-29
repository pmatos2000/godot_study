extends Node2D

@export var gen_scene : PackedScene

const EXPLODE : AudioStream = preload("res://assets/explode.wav")

const GEN_POSITION_INIT_Y: float = -50.0
const GEN_POSITION_INIT_X_MIN: float = 70.0
const GEN_POSITION_INIT_X_MAX: float = 1050.0

@onready var label: Label = $CanvasLayer/Label
@onready var timer: Timer = $Timer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var accept_dialog: AcceptDialog = $CanvasLayer/AcceptDialog


var score : int = 0


func spawn_gen() -> void:
	var new_gen: Gen = gen_scene.instantiate()
	new_gen.on_gen_off_screen.connect(game_over)
	var pos_init_x = randf_range(GEN_POSITION_INIT_X_MIN, GEN_POSITION_INIT_X_MAX)
	new_gen.position = Vector2(pos_init_x, GEN_POSITION_INIT_Y)
	add_child(new_gen)


func stop_all() -> void:
	timer.stop()
	audio_stream_player.stop()
	for child in get_children():
		child.set_process(false)


func play_dead() -> void:
	audio_stream_player_2d.stop()
	audio_stream_player_2d.stream = EXPLODE
	audio_stream_player_2d.play()


func open_accept_dialog() -> void:
	accept_dialog.visible = true
	accept_dialog.dialog_text = "Pontuação: %05d" % score


func game_over() -> void:
	stop_all()
	play_dead()
	open_accept_dialog()



func _on_paddle_area_entered(area: Area2D) -> void:
	audio_stream_player_2d.position = area.position
	audio_stream_player_2d.play()
	Util.remove_node(area)
	score += 1
	label.text = "%05d" % score
