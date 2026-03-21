extends Control

func _ready():
	Audio.menu_music(true)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_menu.tscn")


func _on_levels_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_menu.tscn")


func _on_endless_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/levels/endless.tscn")
