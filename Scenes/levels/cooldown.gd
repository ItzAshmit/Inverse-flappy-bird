extends Sprite2D

@export var cooldown:float = 4.0
@onready var pipe_spawner: Timer = $"../../Timer/PipeSpawner"

var step:float

func _ready():
	cooldown = pipe_spawner.wait_time
	step = cooldown / 8
	frame = 0


func _process(_delta):
	if pipe_spawner.wait_time - pipe_spawner.time_left  != 1:
		if step * frame <= (pipe_spawner.wait_time - pipe_spawner.time_left):
			if frame <= 6:
				frame += 1


func _on_pipe_spawner_timeout() -> void:
	for i in range(-7,1):
		if not frame == 0:
			frame = i * -1
		else:
			frame = 0
		await get_tree().create_timer(0.03).timeout
