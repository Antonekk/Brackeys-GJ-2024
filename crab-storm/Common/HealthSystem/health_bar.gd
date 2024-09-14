extends TextureProgressBar


@export var player : PlayerController


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.health_system.health_change.connect(update)
	value = 100

func update() -> void:
	value = (player.health_system.current_health * 100) / player.health_system.MAX_HEALTH
