extends Bird
func _ready() -> void:
	super()
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	$Timer.start()

func becomeVisible():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)
