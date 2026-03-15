extends Node2D


signal pipe_spawned(y_axis:float)
signal pipe_crossed(y_axis:float)

func _ready() -> void:
	if($BirdParent.get_child_count() == 0):
		var birdscene = load("res://Scenes/bird.tscn")
		var bird = birdscene.instantiate()
		$BirdParent.add_child(bird)
		bird.name = bird
func pipe_spawner() -> int:
	var Pipe_scene = load("res://Scenes/pipe.tscn")
	var pipe = Pipe_scene.instantiate()
	pipe.global_position = get_global_mouse_position()
	# if($CanvasLayer/Buttons.get_child(0).button_pressed):
	# 	pipe.damage = 125
	# 	$CanvasLayer/Buttons.get_child(0).button_pressed=false
	if pipe.global_position.x > 550: 
		if pipe.global_position.y<310:
			pipe.get_node("Upper").queue_free()
			$pipes.add_child(pipe)           
		elif pipe.global_position.y>390: 
			pipe.get_node("Lower").queue_free()
			$pipes.add_child(pipe)   
		else:
			$pipes.add_child(pipe)
		pipe.Area.body_exited.connect(_pipe_crossed.bind(pipe.global_position.y))
		return 1
	return 0
	
func _input(event):
	if event is InputEventMouseButton and $"Timer/PipeSpawner".time_left==0:
		if pipe_spawner():
			pipe_spawned.emit(get_global_mouse_position().y)
			$Timer/PipeSpawner.start()



func _pipe_crossed(_body,y_value):
	pipe_crossed.emit(y_value)
