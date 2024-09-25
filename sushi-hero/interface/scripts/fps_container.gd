extends ColorRect
class_name FpsContainer

@export_category("Objects")
@export var fps: Label = null

func _process(_delta: float) -> void:
	if visible:
		fps.text = "%s Fps" % Engine.get_frames_per_second()
