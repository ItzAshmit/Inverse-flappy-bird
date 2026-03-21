extends Control
var levels_cleared = 0


func _ready():
	load_data()
	for i in $Control.get_children():
		var level_num = str(i.name).substr(5,-1).to_int()
		if not (level_num <= (levels_cleared + 1)):
			i.modulate = Color(1.0, 1.0, 1.0, 0.3)



func _on_button_pressed() -> void:
	var button := get_viewport().gui_get_focus_owner()
	if button:
		var level = str(button.get_parent().name).substr(5,-1).to_int()
		if(level <= (levels_cleared + 1)):
			$AnimationPlayer.play("transition")
			await get_tree().create_timer(1.1).timeout
			get_tree().change_scene_to_file("res://Scenes/levels/" + str(button.get_parent().name) + ".tscn")
			await Audio.menu_music(false)


func load_data():
	var config = ConfigFile.new()
	var save_path = "user://save.cfg"
	var err = config.load("user://save.cfg")
	if err == 0:
		levels_cleared = config.get_value("progress", "levels_cleared", 0)
	else:
		config.set_value("progress", "levels_cleared", 0)
		config.save(save_path)







var hover_node
func _on_button_mouse_entered() -> void:
	hover_node = get_viewport().gui_get_hovered_control()
	var tween := create_tween()
	tween.tween_property(hover_node.get_parent(), "scale", Vector2(1.5,1.5), 0.5).set_trans(Tween.TRANS_ELASTIC)


func _on_button_mouse_exited() -> void:
	if hover_node:
		var tween := create_tween()
		tween.tween_property(hover_node.get_parent(), "scale", Vector2(1,1), 0.5).set_trans(Tween.TRANS_BOUNCE)


func _on_levels_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
