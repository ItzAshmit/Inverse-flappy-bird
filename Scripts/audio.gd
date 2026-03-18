extends AudioStreamPlayer2D

var audio_list:Array = [load("res://Assets/Audio/Demented 90s Cartoon Theme - Rod Kim.mp3"), load("res://Assets/Audio/Every Night Of The Week - Everet Almond.mp3"), load("res://Assets/Audio/Look Both Ways - Nathan Moore.mp3")]

func _ready():
	stream = audio_list.pick_random()
	
func _on_finished() -> void:
	stream = audio_list.pick_random()
	playing = true

func menu_music(play_:bool):
	if play_:
		stream = load("res://Assets/Audio/The Theme - Alex Jones _ Xander Jones.mp3")
		playing = true

	else:
		for i in range(40):
			volume_db = -i
			await get_tree().create_timer(0.05).timeout
		stream = audio_list.pick_random()
		volume_db = 1.0
		playing = true
