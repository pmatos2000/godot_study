extends Node3D

var _interactable: bool = true

@export_group("Object")
@export var _feed_back: MeshInstance3D = null
@export var _animation_player: AnimationPlayer = null
@export var _region: Area3D = null


func _ready() -> void:
	# _region.connect("_on_body_entered", _on_body_entered)
	# _region.connect("_on_body_exited", _on_body_exited)
	pass
	

func _on_body_entered(body: Node3D) -> void:
	_feed_back.visible = true
	_animation_player.play("rotation")


func _on_body_exited(body: Node3D) -> void:
	_feed_back.visible = false
	_animation_player.stop()
