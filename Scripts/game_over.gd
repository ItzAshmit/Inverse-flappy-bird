extends Control





func _on_button_2_pressed() -> void:
	get_tree().paused = false
	await get_tree().process_frame
	get_tree().reload_current_scene()


func _on_button_3_pressed() -> void:
	get_tree().paused = false
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_next_level_pressed() -> void:
	var len_ = get_tree().current_scene.scene_file_path.length() - 30
	var level = get_tree().current_scene.scene_file_path.substr(25,len_).to_int()
	get_tree().change_scene_to_file("res://Scenes/levels/level" + str(level + 1) + ".tscn")
