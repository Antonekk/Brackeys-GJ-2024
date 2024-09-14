extends TextureProgressBar


@export var crab : CrabController


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	crab.crab_health_system.health_change.connect(update)
	update()

func update() -> void:
	value = (crab.crab_health_system.current_health * 100) / crab.crab_health_system.MAX_HEALTH
