extends Node2D
class_name HealthSystem

@export var MAX_HEALTH : int = 10
var current_health : int
signal health_change

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = MAX_HEALTH

func apply_damage(damage : int) -> void:
	current_health -= damage
	health_change.emit()
	if current_health < 0:
		handle_death()
		
		
func handle_death() -> void:
	get_parent().queue_free()
