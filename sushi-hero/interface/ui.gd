extends CanvasLayer
class_name  UiClass

@export_category("Objects")
@export var setting_container: SettingContainer = null
@export var fps_container: FpsContainer = null


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Menu"):
		if setting_container.visible:
			setting_container.visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			setting_container.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
