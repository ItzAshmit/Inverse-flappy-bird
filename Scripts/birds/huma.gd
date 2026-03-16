extends Bird
func teleport():
	global_position.x += 50

func becomeInvisible():
	if($Timer.time_left>0 or  modulate.a<1): return
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	$Timer.start()

func becomeVisible():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)

func _physics_process(_delta: float):
	super(_delta)
	if(health<=maxhealth/2 and $Timer.time_left==0): 
		becomeInvisible()
