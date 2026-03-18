extends Node

var bird
var animation
var clock

func _ready():
	await get_tree().create_timer(2).timeout
	bird = $"../BirdParent".get_child(0)
	animation = get_parent().get_node("AnimationPlayer")
	clock = get_parent().get_node("CanvasLayer/clock")
	clock.finished.connect(_timer_ended)
	bird.bird_died.connect(_bird_died)





func _timer_ended():
	animation.play("shaking")
	Audio.volume_db = -10
	%AudioStreamPlayer2D.playing = true




func _bird_died():
	var tween := create_tween()

	tween.tween_property(bird, "rotation_degrees", 90, 0.5)
	tween.tween_property($"../Camera2D", "position", Vector2(400,-50), 2).set_trans(Tween.TRANS_ELASTIC)
	tween.parallel()
	tween.tween_property(bird, "global_position", Vector2(bird.global_position.x, 500), 0.5)
