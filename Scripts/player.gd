extends CharacterBody2D
var speed:int = 150
var gravity:int = 10
var jumped = false
var goingdown = false
func _ready() -> void:
	velocity =  Vector2.UP*speed

func diving(out):
	print(out)
func jump(out):
	if(goingdown or jumped): return
	velocity.y = -speed
	jumped = true
	goingdown = false
	print(out)

func get_collider_layer(ray) -> int:
	if ray.is_colliding():
		return ray.get_collider().collision_layer
	return -1

func _physics_process(_delta: float) -> void:
	jumped = false
	velocity.y += gravity
	if $below.is_colliding() or $below2.is_colliding() and (get_collider_layer($below) == 4 or get_collider_layer($below2) == 4):
		goingdown=false
		jump("3")
	elif ($above.is_colliding() or $above2.is_colliding()) and (get_collider_layer($above) == 2 or get_collider_layer($above2) == 2):
		goingdown=true
		diving("c")
	else:
		print("k")
		if $front.is_colliding():
			print($front.get_collider())
			if $front.get_collider().collision_layer == 2:
				goingdown=true
				diving("a")
			else:
				goingdown=false
				jump("1")
		else:
			if ($"../pipes".get_child_count()==0) and (not $front.is_colliding()) and (not $above.is_colliding()) and (not $"front-above".is_colliding()) and (not $below.is_colliding()) and (not $"front-below".is_colliding()):
				print("q")
				goingdown = false
			if $"front-above".is_colliding() or $"front-below".is_colliding():
				print("t")
				if $"front-above".is_colliding():
					print("w")
					goingdown = true
					diving("b")
				else: 
					print("e")
					goingdown = false
					jump("2")
			if(global_position.y >= randi_range(350,450)):
				print("r")
				jump("4")
	move_and_slide()
