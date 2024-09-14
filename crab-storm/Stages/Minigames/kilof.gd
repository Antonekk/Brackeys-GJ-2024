extends AnimatedSprite2D

var enabled = true

func _ready() -> void:
	SignalBus.level_change.connect(Disable)
	
func Disable(temp):
	stop()
	enabled = false

func _physics_process(delta: float) -> void:
	if enabled:
		if Input.is_action_just_pressed("lmb") or Input.is_action_just_pressed("rmb"):
			stop()
			play("kilof")
