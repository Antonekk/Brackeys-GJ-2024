extends RichTextLabel

@onready var timer: Timer = $Timer

func _ready() -> void:
	SignalBus.level_change.connect(stop)
	SignalBus.new_scene_loaded.connect(start)
func stop(t):
	timer.paused = true
	
func start():
	timer.paused = false

func _process(delta: float) -> void:
	text = str(int(timer.time_left))
