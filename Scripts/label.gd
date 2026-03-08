extends Label


func _process(_delta: float) -> void:
	text = "Cooldown: " + str($"../../Timer/PipeSpawner".time_left)
