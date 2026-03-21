extends Node2D
var time_passed = 0.0
var color
@export var cycle_duration: float = 300.0 
@export var saturation:     float = 0.6
@export var value:          float = 0.85

func _process(delta: float) -> void:
    if(time_passed >= cycle_duration):
        time_passed = 0.0
        value += 0.1
        if(value > 1.0):
            value -= 0.5
    time_passed += delta
    var hue: float = fmod(time_passed / cycle_duration, 1.0)
    color = Color.from_hsv(hue, saturation, value)
    self.modulate = color