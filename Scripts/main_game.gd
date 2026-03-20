extends Node2D

var len_
var level
var is_in_area:bool
var has_started:bool = false
var pipe_after = 2
@export var time:float = 300.0
signal pipe_spawned(y_axis:float)
signal pipe_crossed(y_axis:float)

func _ready() -> void:
	len_ = get_tree().current_scene.scene_file_path.length() - 30
	level = get_tree().current_scene.scene_file_path.substr(25,len_).to_int()
	if(level<=5): time = 30
	elif(level<=10): time = 20
	elif(level<=15): time = 15
	else: time = 10
	$Area2D/Panel.modulate = Color(1.0,1.0,1.0,0.0)
	$CanvasLayer/clock.finished.connect(_timer_finished)
func pipe_spawner() -> int:
	var Pipe_scene = load("res://Scenes/pipe.tscn")
	var pipe = Pipe_scene.instantiate()
	pipe.global_position = get_global_mouse_position()
	var ret = pipe_manager(pipe)
	if is_in_area and not $Area2D.get_overlapping_areas().size() and get_local_mouse_position().x > 550:
		if pipe.global_position.y<220:
			pipe.get_node("Upper").queue_free()
			pipe.get_node("Upper2").queue_free()
			$pipes.add_child(pipe)           
		elif pipe.global_position.y>380: 
			pipe.get_node("Lower").queue_free()
			pipe.get_node("Lower2").queue_free()
			$pipes.add_child(pipe)   
		else:
			$pipes.add_child(pipe)
		pipe.Area.body_exited.connect(_pipe_crossed.bind(pipe.global_position.y))
		pipe_after+=1
		if(ret): $Timer/PipeSpawner.start()
		else: $Timer/Timer.start()   
		return 1
	return 0
	
func _input(event):
	if not has_started:
		$CanvasLayer/clock.start_clock(time)
		has_started = true
	if event is InputEventMouseButton and $"Timer/PipeSpawner".time_left==0 and $Timer/Timer.time_left==0:
		if pipe_spawner():
			pipe_spawned.emit(get_global_mouse_position().y)

func _pipe_crossed(_body,y_value):
	pipe_crossed.emit(y_value)

func pipe_manager(pipe) -> int:
	var ret = 1 
	if(level==5):
		if($CanvasLayer/Buttons.get_child(1).button_pressed):
			pipe.upspeed = 15
			pipe_after=-1
			$CanvasLayer/Buttons.get_child(1).button_pressed=false
		elif($CanvasLayer/Buttons.get_child(0).button_pressed):
			pipe.upspeed = -15
			pipe_after=-1
			$CanvasLayer/Buttons.get_child(0).button_pressed=false
	elif(level==7):
		pipe.speed += 20
	elif(level==8):
		pipe.speed += 50
	if(level==9):
		if($CanvasLayer/Buttons.get_child(2).button_pressed):
			pipe.damage =0
			pipe.modulate = Color(1.0,1.0,1.0,0.5)
			ret = 0
			pipe_after=-1
			$CanvasLayer/Buttons.get_child(2).button_pressed=false
	if(level == 14):
		if($CanvasLayer/Buttons.get_child(3).button_pressed):
			pipe.gap -= 20
			ret = 0
			pipe_after=-1
			$CanvasLayer/Buttons.get_child(3).button_pressed=false
	if(level == 15):
		if($CanvasLayer/Buttons.get_child(3).button_pressed):
			pipe.gap -= 40
			ret = 0
			pipe_after=-1
			$CanvasLayer/Buttons.get_child(3).button_pressed=false
	if(level>=16):
		pipe.speed += 20
	if(level>=17):
		pipe.gap += 20
	if(level>=18):
		if($CanvasLayer/Buttons.get_child(1).button_pressed):
			pipe.upspeed = 15
			pipe_after=-1
			$CanvasLayer/Buttons.get_child(1).button_pressed=false
		elif($CanvasLayer/Buttons.get_child(0).button_pressed):
			pipe.upspeed = -15
			pipe_after=-1
			$CanvasLayer/Buttons.get_child(0).button_pressed=false
	if(level>=19):
		if($CanvasLayer/Buttons.get_child(3).button_pressed):
			pipe.gap -= 20
			ret = 0
			pipe_after=-1
			$CanvasLayer/Buttons.get_child(3).button_pressed=false
	return ret


func _timer_finished():
	if(!$BirdParent.get_child(0).get_node("CanvasLayer/Game_over").visible): 
		$BirdParent.get_child(0).get_node("CanvasLayer/Game_lost").visible = true
	get_tree().paused = true
	
	


func _on_area_2d_mouse_entered() -> void:
	is_in_area = true
	var tween := create_tween()
	tween.tween_property($Area2D/Panel, "modulate:a", 1, 0.5)

func _on_area_2d_mouse_exited() -> void:
	is_in_area = false
	var tween := create_tween()
	tween.tween_property($Area2D/Panel, "modulate:a", 0, 0.5)


func _on_button_hard_toggled(toggled_on: bool) -> void:
	if(toggled_on and pipe_after<2): $CanvasLayer/Buttons/ButtonHard.button_pressed=false


func _on_button_invi_toggled(toggled_on: bool) -> void:
	if(toggled_on and pipe_after<2): $CanvasLayer/Buttons/ButtonInvi.button_pressed=false


func _on_button_up_toggled(toggled_on: bool) -> void:
	if(toggled_on and pipe_after<2): $CanvasLayer/Buttons/ButtonUp.button_pressed=false


func _on_button_down_toggled(toggled_on: bool) -> void:
	if(toggled_on and pipe_after<2): $CanvasLayer/Buttons/ButtonDown.button_pressed=false
