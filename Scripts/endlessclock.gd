extends Control
@export var initial_time: float = 10
var time_went = 0
var time_left: float = initial_time
var buttons
var buttons_enabled = 0
signal finished()


func start_clock(_timegiven):
	modulate = Color(1.0,1.0,1.0,1.0)

func _physics_process(delta: float):
	if initial_time != null:
		$hand.rotation_degrees = 360*(1-time_left/initial_time)
		time_left -= delta
		time_went += delta
	if time_left <= 0:
		time_left = 0
		$hand.rotation_degrees = 360
		finished.emit()
	if(time_went >= 10 and buttons_enabled == 0):
		buttons_enabled += 1
		buttons = self.get_parent().get_node("Buttons")
		buttons.get_child(0).disabled = false
	elif(time_went >= 20 and buttons_enabled == 1):
		buttons_enabled += 1
		buttons.get_child(1).disabled = false
	elif(time_went >= 30 and buttons_enabled == 2):
		buttons_enabled += 1
		buttons.get_child(2).disabled = false
	elif(time_went >= 120 and buttons_enabled == 3):
		buttons_enabled += 1
		buttons.get_child(3).disabled = false
