extends CharacterBody2D
var speed:int = 150
var gravity:int = 10
var jumped = false
func _ready() -> void:
	velocity =  Vector2.UP*speed

func jump():
	velocity.y = -speed
	jumped = true

func _physics_process(_delta: float) -> void:
	jumped = false
	velocity.y += gravity
	if $front.is_colliding() and ($front.get_collider().collision_layer == 3):
		print(1)
		jump()
	if $"front-above".is_colliding() and (not jumped) and ($"front-above".get_collider().collision_layer == 3):
		print(2)
		jump()
	if $"front-below".is_colliding() and (not jumped) and ($"front-below".get_collider().collision_layer == 3):
		print(3)
		jump()	
	if $below.is_colliding():
		jump()
	if(global_position.y >= randi_range(350,450)) and not jumped:
		jump()

	move_and_slide()
