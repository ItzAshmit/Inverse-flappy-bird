extends Node2D
func pipe_spawner() -> void:
	var Pipe_scene = load("res://Scenes/pipe.tscn")
	var pipe = Pipe_scene.instantiate()
	pipe.global_position = get_global_mouse_position()
	if pipe.global_position.y<310:
		pipe.get_node("Upper").queue_free()
		$pipes.add_child(pipe)           
	elif pipe.global_position.y>390: 
		pipe.get_node("Lower").queue_free()
		$pipes.add_child(pipe)   
	else:
		$pipes.add_child(pipe)
	
func _input(event):
	if event is InputEventMouseButton and $"Timer/PipeSpawner".time_left==0:
		if get_global_mouse_position().x < 550:
			return
		$Timer/PipeSpawner.start()
		pipe_spawner()
