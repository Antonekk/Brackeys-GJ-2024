extends TextureProgressBar


@export var entity_health : HealthSystem
const SHOW_HEALTH : float = 4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	entity_health.health_change.connect(update)
	update()
	visible = false

func update() -> void:
	visible = true
	value = (entity_health.current_health * 100) / entity_health.MAX_HEALTH
	await get_tree().create_timer(SHOW_HEALTH).timeout
	visible= false
