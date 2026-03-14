extends Node2D
func _ready() -> void:
	if($BirdParent.get_child_count()==0):
		var birdscene = preload("res://Scenes/bird.tscn")
		var bird = birdscene.instantiate()
		$BirdParent.add_child(bird)
	$CanvasLayer/health.scale.x = $CanvasLayer/health.scale.x*$BirdParent.get_child(0).maxhealth/100
	$CanvasLayer/health/healthline.pivot_offset = Vector2(14.14,18.8)
func pipe_spawner() -> int:
	var Pipe_scene = load("res://Scenes/pipe.tscn")
	var pipe = Pipe_scene.instantiate()
	pipe.global_position = get_global_mouse_position()
	if pipe.global_position.x> 380 and pipe.global_position.x< 440: 
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
		if(pipe_spawner()==1):
			$Timer/PipeSpawner.start()

func _process(_delta: float) -> void:
	$CanvasLayer/health/healthline.scale.x = $BirdParent.get_child(0).health/100
