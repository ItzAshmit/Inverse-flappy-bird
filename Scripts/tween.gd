extends Node

var bird

func _ready():
	await get_tree().create_timer(2).timeout
	bird = $"../BirdParent".get_child(0)
	bird.bird_died.connect(_bird_died)










func _bird_died():
	var tween := create_tween()
	tween.tween_property(bird, "rotation_degrees", 90, 0.5)
	tween.tween_property(bird, "global_position", Vector2(bird.global_position.x, 500), 0.5)
