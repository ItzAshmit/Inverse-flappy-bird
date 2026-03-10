extends Node2D
var speed = 100
func _process(delta: float) -> void:
	position.x -= speed*delta

func _on_body_entered(_body: Node2D) -> void:
	$"../../Bird".health -= 50
	$"../../Bird".animation.play("new_animation")
	if($"../../Bird".health == 0): 
		$Timer.start()

func over():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func _on_screen_exited() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	call_deferred("over")
