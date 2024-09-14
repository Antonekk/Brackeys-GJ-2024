extends TextureProgressBar


@export var entity_health : HealthSystem
const SHOW_HEALTH : float = 2.5
var health_show_timer : SceneTreeTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_show_timer = get_tree().create_timer(0.1)
	entity_health.health_change.connect(update)
	update()
	visible = false

func update() -> void:
	value = (entity_health.current_health * 100) / entity_health.MAX_HEALTH
	health_show_timer = get_tree().create_timer(SHOW_HEALTH)

func _process(delta: float) -> void:
	if health_show_timer.time_left == 0:
		visible = false
	else:
		visible = true
