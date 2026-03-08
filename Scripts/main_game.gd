extends Node2D

func pipe_spawner() -> void:
	var Pipe_scene = load("res://Scenes/pipe.tscn")
	var pipe = Pipe_scene.instantiate()
	pipe.global_position = get_global_mouse_position()
	$pipes.add_child(pipe)
	
func _input(event):
	if event is InputEventMouseButton and $"Timer/PipeSpawner".time_left==0:
		$Timer/PipeSpawner.start()
		pipe_spawner()
