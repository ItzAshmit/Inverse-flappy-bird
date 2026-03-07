extends Node2D
var speed = 100


func _process(delta: float) -> void:
	position.x -= speed*delta



func _on_upper_body_entered(_body: Node2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")


