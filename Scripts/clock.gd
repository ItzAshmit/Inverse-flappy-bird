extends Control

signal finished()


func start_clock(time):
	var tween = create_tween()
	tween.tween_property($hand, "rotation_degrees", 360, time)
	await tween.finished
	finished.emit()