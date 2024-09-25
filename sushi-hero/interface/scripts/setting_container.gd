extends ColorRect
class_name SettingContainer


func _on_check_box_full_screen(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_option_button_vsync_item_selected(index: int) -> void:
	match  index:
		0:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		1:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		2:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
		_:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_check_box_display_fps(toggled_on: bool) -> void:
	if Ui is UiClass:
		var ui_class: UiClass = Ui as UiClass;
		if ui_class.fps_container:
			ui_class.fps_container.visible = toggled_on;


func _on_option_button_screen_space_item_selected(index: int) -> void:
	pass
