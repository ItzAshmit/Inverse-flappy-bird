extends Node2D

@onready var Area:Area2D = $Area2D

@export var speed = 100
@export var damage = 100
@export var upspeed = 0
@export var downspeed = 0
func _process(delta: float) -> void:
	if upspeed:
		position.y -= upspeed * delta
	if downspeed:
		position.y += downspeed * delta

	position.x -= speed*delta

func _on_body_entered(_body: Node2D) -> void:
	$"../../BirdParent".get_child(0).damage(self)
	$"../../BirdParent".get_child(0).animation.play("new_animation")

func _on_screen_exited() -> void:
	queue_free()


