extends Area2D
class_name HitboxComponent

@export var health_component : HealthSystem

func damage(dmg : int) -> void :
	if health_component:
		health_component.apply_damage(dmg)
