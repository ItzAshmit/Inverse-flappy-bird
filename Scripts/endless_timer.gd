extends Label

var playing:bool = true
var time:float = 0


func _process(delta):
	if playing:
		time += delta
		text = "Score - " + str(round(time)/10)


var has_started:bool = false
func _input(_event):
	if not has_started:
		playing = true
		has_started = true
