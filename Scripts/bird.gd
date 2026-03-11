extends CharacterBody2D
class_name Bird
@export var maxhealth: float = 100
@export var defense: float = 50
@export var lives: int = 1
var health : float
var speed:int = 150
var gravity:int = 10
var jumped = false
var goingdown = false
@onready var animation:AnimationPlayer = $AnimationPlayer
var birdup = preload("res://Assets/Flappy Bird Assets/Birdup.png")
var birddown = preload("res://Assets/Flappy Bird Assets/Birddown.png")
func _ready() -> void:
	health = maxhealth
	velocity =  Vector2.UP*speed

func jump():
	if(goingdown or jumped): return
	velocity.y = -speed
	jumped = true
	goingdown = false

func get_collider_layer(ray) -> int:
	if ray.is_colliding():
		return ray.get_collider().collision_layer
	return -1

func die():
	lives-=1
	if(lives==0):
		call_deferred("over")
	else:
		health = maxhealth

func over():
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func damage(pipe):
	health -= pipe.damage-defense
	if(health<0): health =0


func _physics_process(_delta: float) -> void:
	if(velocity.y>0): $Image.texture = birddown
	else: $Image.texture = birdup
	jumped = false
	velocity.y += gravity
	if $below.is_colliding() or $below2.is_colliding() and (get_collider_layer($below) == 4 or get_collider_layer($below2) == 4):
		goingdown=false
		jump()
	elif ($above.is_colliding() or $above2.is_colliding()) and (get_collider_layer($above) == 2 or get_collider_layer($above2) == 2):
		goingdown=true
	else:
		if $front.is_colliding():
			if $front.get_collider().collision_layer == 2:
				goingdown=true
			else:
				goingdown=false
				jump()
		else:
			if ($"../../pipes".get_child_count()==0) and (not $front.is_colliding()) and (not $above.is_colliding()) and (not $"front-above".is_colliding()) and (not $below.is_colliding()) and (not $"front-below".is_colliding()):
				goingdown = false
			if $"front-above".is_colliding() or $"front-below".is_colliding():
				if $"front-above".is_colliding():
					goingdown = true
				else: 
					goingdown = false
					jump()
			if(global_position.y >= randi_range(350,450)):
				jump()
	move_and_slide()
