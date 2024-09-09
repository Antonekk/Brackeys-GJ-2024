extends Node
class_name HealthComponent

@export var MAX_HEALTH := 10
var current_health : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = MAX_HEALTH

func apply_damage(damage : float) -> void:
	current_health -=damage
	if current_health < 0:
		handle_death()
		
		
func handle_death() -> void:
	get_parent().queue_free()
