extends Control

@export var is_endless_mode:bool = false
@export var is_timer_out:bool = false

func _ready() -> void:
	EndlessTimer.time = 0

func _on_button_2_pressed() -> void:
	get_tree().paused = false
	await get_tree().process_frame
	Audio.volume_db = 0
	get_tree().reload_current_scene()


func _on_button_3_pressed() -> void:
	get_tree().paused = false
	await get_tree().process_frame
	Audio.volume_db = 0
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_next_level_pressed() -> void:
	get_tree().paused = false
	var len_ = get_tree().current_scene.scene_file_path.length() - 30
	var level = get_tree().current_scene.scene_file_path.substr(25,len_).to_int()
	Audio.volume_db = 0
	get_tree().change_scene_to_file("res://Scenes/levels/level" + str(level + 1) + ".tscn")


func _process(_delta):
	if is_endless_mode:
		var time = EndlessTimer.time
		$Label2.text = "Score - " + str(round(time)/10)
	else:
		if has_node("Label2"):
			$Label2.visible = false
