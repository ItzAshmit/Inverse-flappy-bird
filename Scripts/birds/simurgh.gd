extends Bird
var initialx
func _ready() -> void:
	super()
	initialx = global_position.x
func teleport():
	global_position.x += 50

func _physics_process(delta: float) -> void:
	super(delta)
	if(health<=50): 
		if(initialx==global_position.x):
			teleport()
