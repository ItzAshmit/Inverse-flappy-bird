extends Control

signal finished()


func start_clock(time):
	modulate = Color(1.0,1.0,1.0,1.0)
	var tween = create_tween()
	tween.tween_property($hand, "rotation_degrees", 360, time)
	await tween.finished
	finished.emit()
