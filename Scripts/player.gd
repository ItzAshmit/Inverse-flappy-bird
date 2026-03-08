extends CharacterBody2D
var speed= 250
var gravity = 10
func _ready() -> void:
	velocity =  Vector2.UP*speed



func jump():
	velocity.y = -speed




func _physics_process(_delta: float) -> void:
	velocity.y += gravity
	move_and_slide()
	if($Timer.time_left==0): 
		jump()
		$Timer.start()
