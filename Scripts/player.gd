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

func _physics_process(_delta: float) -> void:
	jumped = false
	velocity.y += gravity
	if $above.is_colliding() or $above2.is_colliding():
		goingdown=true
		diving("c")
	elif $below.is_colliding() or $below2.is_colliding():
		jump("3")
	else:
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
				goingdown = false
			if $"front-above".is_colliding() or $"front-below".is_colliding():
				if $"front-above".is_colliding():
					goingdown = true
					diving("b")
				else:
					jump("2")
			if(global_position.y >= randi_range(350,450)):
				jump("4")
	move_and_slide()
