extends Sprite2D

@export var cooldown:float = 4.0
@onready var pipe_spawner: Timer = $"../../Timer/PipeSpawner"

var step:float

func _ready():
	cooldown = pipe_spawner.wait_time
	step = cooldown / 8
	frame = 0
	print(step)


func _process(_delta):
	print(frame)
	var elapsed := pipe_spawner.wait_time - pipe_spawner.time_left
	var target_frame := int(elapsed / step)
	frame = clamp(target_frame, 0, 7)


func _on_pipe_spawner_timeout() -> void:
	frame = 0
	await get_tree().create_timer(0.03).timeout
