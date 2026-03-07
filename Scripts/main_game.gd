extends Node2D




func pipe_spawner() -> void:
	var Pipe_scene = load("res://Scenes/pipe.tscn")
	var pipe = Pipe_scene.instantiate()
	pipe.position = Vector2(1200,randi_range(120,600))
	$Pipes.add_child(pipe)
