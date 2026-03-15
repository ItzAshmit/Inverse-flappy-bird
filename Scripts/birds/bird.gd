extends CharacterBody2D
class_name Bird
@export var maxhealth: float = 100
@export var defense: float = 50
@export var lives: int = 1
@export var ran_factor:float = 0
var health : float
var speed:int = 150
var gravity:int = 10
var jumped = false
var goingdown = false
var jump_value:Array = []
@onready var animation:AnimationPlayer = $AnimationPlayer
var birdup = preload("res://Assets/Flappy Bird Assets/Birdup.png")
var birddown = preload("res://Assets/Flappy Bird Assets/Birddown.png")

signal bird_died

func _ready() -> void:
	get_parent().get_parent().pipe_spawned.connect(_pipe_spawned)
	get_parent().get_parent().pipe_crossed.connect(_pipe_crossed)
	$CanvasLayer/Game_over.visible = false
	health = maxhealth
	$CanvasLayer/TextureProgressBar.visible = true
	$CanvasLayer/TextureProgressBar.max_value = maxhealth
	$CanvasLayer/TextureProgressBar.value = health
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
		bird_died.emit()
		await get_tree().create_timer(0.5).timeout
		create_tween().tween_property($CanvasLayer/TextureProgressBar, "value", health, 1.5).set_trans(Tween.TRANS_BOUNCE)
		$CanvasLayer/Game_over.visible = true
		$CanvasLayer/Game_over.scale = Vector2(0.001,0.001)
		create_tween().tween_property($CanvasLayer/Game_over, "scale", Vector2(1,1), 1.5).set_trans(Tween.TRANS_ELASTIC)
		await get_tree().create_timer(1.5).timeout
		over()
		get_tree().paused = true
	else:
		health = maxhealth

func over():
	var config = ConfigFile.new()
	config.load("user://save.cfg")
	var maxlevel = config.get_value("progress", "levels_cleared", 0)
	var len_ = get_tree().current_scene.scene_file_path.length() - 30
	var level = get_tree().current_scene.scene_file_path.substr(25,len_).to_int()
	if(maxlevel<level):
		config.set_value("progress", "levels_cleared", level)
	config.save("user://save.cfg")

func damage(pipe):
	health -= pipe.damage-defense
	create_tween().tween_property($CanvasLayer/TextureProgressBar, "value", health, 1.5).set_trans(Tween.TRANS_BOUNCE)
	if(health <= 0):
		die()

func _physics_process(_delta: float) -> void:
	var value:float
	if jump_value.is_empty(): value = 300 
	else: value = jump_value[0]

	if(randf() >= ran_factor):
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
				if(global_position.y >= randf_range(value,value + 50.0)):
					jump()

		
	else:
		if(global_position.y >= randf_range(value,value + 50.0)):
			jump()
	move_and_slide()




func _pipe_spawned(y_value):
	jump_value.append(y_value)
	print(jump_value)




func _pipe_crossed(y_value):
	jump_value.erase(y_value)
