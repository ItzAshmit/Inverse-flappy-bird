extends CharacterBody2D
var speed= 250
var gravity = 10
func _ready() -> void:
	velocity =  Vector2.UP*speed
func _physics_process(_delta: float) -> void:
	if(Input.is_action_just_pressed("Jump")):
		velocity.y = -speed
	velocity.y += gravity
	move_and_slide()
