extends Sprite2D

@export var cooldown:float = 4.0

var step:float

func _ready():
	step = cooldown / 8
	frame = 0
	timer()


	

var time = 0
func timer():
	while time < cooldown:
		if step * frame <= time:
			frame += 1
			if frame == 7:
				frame = 0
		time += 0.1
		await get_tree().create_timer(0.1).timeout