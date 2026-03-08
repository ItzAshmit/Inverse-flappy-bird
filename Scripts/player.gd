extends CharacterBody2D
var speed:int = 250
var gravity:int = 10
var has_pipes_to_dogde:bool = false
func _ready() -> void:
	velocity =  Vector2.UP*speed



func jump():
	velocity.y = -speed



func _physics_process(_delta: float) -> void:
	velocity.y += gravity
	
	if $RayCast2D.is_colliding():
		has_pipes_to_dogde = true
		if $RayCast2D.get_collider().collision_layer == 4:
			jump()
			has_pipes_to_dogde = false
	
	# if $RayCast2D2.is_colliding(): 
	# 	if $RayCast2D.get_collider():
	# 		if $RayCast2D.get_collider().collision_layer == 2:
	# 			has_pipes_to_dogde = true

	if $RayCast2D3.is_colliding() and not $RayCast2D2.is_colliding():
		jump()

	if $RayCast2D3.is_colliding() and $RayCast2D2.is_colliding():
		has_pipes_to_dogde = true

	if not $RayCast2D.is_colliding() and not $RayCast2D2.is_colliding() and not $RayCast2D3.is_colliding():
		has_pipes_to_dogde = false

	if $RayCast2D4.is_colliding():
		jump()

	if(global_position.y >= randi_range(350,450)) and not has_pipes_to_dogde:
		jump()

	move_and_slide()
