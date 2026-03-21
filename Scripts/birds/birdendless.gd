extends Bird
var clock
@export var time: float = 2
func _ready() -> void:
	super()
	clock = self.get_parent().get_parent().get_node("CanvasLayer/clock")
func damage(_pipe):
	clock.time_left += time
