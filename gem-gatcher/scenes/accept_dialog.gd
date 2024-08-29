extends AcceptDialog


func _on_accept_dialog_confirmed() -> void:
	get_tree().reload_current_scene()


func _on_accept_dialog_canceled() -> void:
	get_tree().quit()
