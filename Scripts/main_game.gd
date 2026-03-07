extends Node2D




func pipe_spawner() -> void:
	var Pipe_scene = load("res://Scenes/pipe.tscn")
	print(Pipe_scene)
	var pipe = Pipe_scene.instantiate()
	pipe.position = Vector2(1200,randi_range(275,425))
	$pipes.add_child(pipe)
