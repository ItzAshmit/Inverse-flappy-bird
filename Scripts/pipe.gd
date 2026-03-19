extends Node2D

@onready var Area:Area2D = $Area2D
@export var gap = 150
@export var speed = 100
@export var damage = 100
@export var upspeed: int = 0
@export var downspeed: int = 0

func _ready() -> void:
	@warning_ignore("integer_division")
	$Upper.position.y = -gap/2
	@warning_ignore("integer_division")
	$Lower.position.y = gap/2
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


func body_entered_2(body: Node2D) -> void:
	body.will_collide = true
