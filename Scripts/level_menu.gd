extends Control


func _on_button_pressed() -> void:
	var button := get_viewport().gui_get_focus_owner()
	if button:
		get_tree().change_scene_to_file("res://Scenes/levels/" + str(button.get_parent().name) + ".tscn")
		print(button.get_parent().name)
