extends Node2D

var Pipe_scene = preload("res://Scenes/pipe.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func pipe_spawner() -> void:
	var pipe = Pipe_scene.instantiate()
	pipe.position = Vector2(400,randi_range(120,600))
	$Pipes.add_child(pipe)
