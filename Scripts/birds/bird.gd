extends CharacterBody2D
class_name Bird
@export var maxhealth: float = 125
@export var defense: float = 50
@export var lives: int = 1
@export var ran_factor:float = 0
var will_collide = false
var len_
var level
var health : float
var pipes
var speed:int = 100
var gravity:int = 320
var jumped = false
var goingdown = false
var jump_value:Array = []
@onready var animation:AnimationPlayer = $AnimationPlayer
var birdup = preload("res://Assets/Flappy Bird Assets/Birdup.png")
var birddown = preload("res://Assets/Flappy Bird Assets/Birddown.png")

signal bird_died

func becomeInvisible():
	if($Timer.time_left > 0 or  modulate.a < 1): return
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	$Timer.start()

func becomeVisible():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)

func teleport():
	$CollisionShape2D.disabled = true
	position.x+=50
	$CollisionShape2D.disabled = false
	will_collide = false
func _ready() -> void:
	pipes = self.get_parent().get_parent().get_node("pipes")
	len_ = get_tree().current_scene.scene_file_path.length() - 30
	level = get_tree().current_scene.scene_file_path.substr(25,len_).to_int()
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
	if ray.is_colliding() and ray.get_collider():
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
	if(maxlevel < level):
		config.set_value("progress", "levels_cleared", level)
	config.save("user://save.cfg")

func damage(pipe):
	health -= pipe.damage-defense
	create_tween().tween_property($CanvasLayer/TextureProgressBar, "value", health, 1.5).set_trans(Tween.TRANS_BOUNCE)
	if(health <= 0):
		die()

func _physics_process(delta: float) -> void:
	var value:float
	if jump_value.is_empty(): value = 300 
	else: value = jump_value[0]

	if global_position.y > 430 and health > 0:
		goingdown = false
		jump()
	if(health <= 2*maxhealth/3 and $Timer.time_left==0 and(level==10 or level == 11 or level>15)): 
		becomeInvisible()
	if($Teleport_timer.time_left==0 and(level==12 or level == 13 or level>15)):
		velocity.x = 0
		if(pipes.get_child_count()!=0):
			if(will_collide):
				teleport()
				$Teleport_timer.start()
				velocity.x = -10
				return
	if(randf() >= ran_factor):
		if(velocity.y>0): $Image.texture = birddown
		else: $Image.texture = birdup
		jumped = false
		velocity.y += gravity*delta
		if $below.is_colliding() or $below2.is_colliding() and (get_collider_layer($below) == 4 or get_collider_layer($below2) == 4):
			goingdown=false
			jump()
		elif ($above.is_colliding() or $above2.is_colliding()) and (get_collider_layer($above) == 2 or get_collider_layer($above2) == 2):
			goingdown=true
		else:
			if $front.is_colliding() and $front.get_collider():
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

func _pipe_crossed(y_value):
	jump_value.erase(y_value)
