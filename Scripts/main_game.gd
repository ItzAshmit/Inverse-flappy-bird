extends Node2D


signal pipe_spawned(y_axis:float)


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
	pipe_manager(pipe)
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
		return 1
	return 0
	
func _input(event):
	if event is InputEventMouseButton and $"Timer/PipeSpawner".time_left==0:
		if pipe_spawner():
			pipe_spawned.emit(get_global_mouse_position().y)
			$Timer/PipeSpawner.start()

func pipe_manager(pipe):
	var len_ = get_tree().current_scene.scene_file_path.length() - 30
	var level = get_tree().current_scene.scene_file_path.substr(25,len_).to_int()
	if(level==5):
		if($CanvasLayer/Buttons/Button.button_pressed):
			pipe.upspeed = 15
			$CanvasLayer/Buttons/Button.button_pressed=false
	
