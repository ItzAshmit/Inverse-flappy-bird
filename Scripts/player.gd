extends CharacterBody2D
var speed:int = 150
var gravity:int = 10
var jumped = false
var goingdown = false
func _ready() -> void:
	velocity =  Vector2.UP*speed

func jump():
	velocity.y = -speed
	jumped = true

func _physics_process(_delta: float) -> void:
	jumped = false
	velocity.y += gravity
	if (not $front.is_colliding()) and (not $above.is_colliding()) and (not $"front-above".is_colliding()) and (not $below.is_colliding()) and (not $"front-below".is_colliding()):
		goingdown = false
	if $front.is_colliding() and ($front.get_collider().collision_layer == 4):
		print($front.get_collider().collision_layer)
		goingdown = false
		jump()
	if $"front-above".is_colliding() and (not $front.is_colliding()):
		goingdown = true
	if $below.is_colliding():
		jump()
	if $above.is_colliding():
		goingdown=true
	if $front.is_colliding() and ($front.get_collider().collision_layer == 2):
		goingdown=true
	if $"front-below".is_colliding() and (not $front.is_colliding()):
		goingdown = false
		jump()
	if(global_position.y >= randi_range(350,450)) and (not jumped) and (not goingdown):
		jump()
	move_and_slide()
