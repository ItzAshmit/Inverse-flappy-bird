extends Node2D
var speed = 100
func _process(delta: float) -> void:
	position.x -= speed*delta

func _on_body_entered(_body: Node2D) -> void:
	$"../../BirdParent".get_child(0).health -= 50
	$"../../BirdParent".get_child(0).animation.play("new_animation")
	if($"../../BirdParent".get_child(0).health == 0):
		call_deferred("over")


func over():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func _on_screen_exited() -> void:
	queue_free()
