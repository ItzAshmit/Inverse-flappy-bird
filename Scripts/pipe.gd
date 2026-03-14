extends Node2D
@export var speed = 100
@export var damage = 100
func _process(delta: float) -> void:
	position.x -= speed*delta

func _on_body_entered(_body: Node2D) -> void:
	$"../../BirdParent".get_child(0).damage(self)
	$"../../BirdParent".get_child(0).animation.play("new_animation")

func _on_screen_exited() -> void:
	queue_free()
