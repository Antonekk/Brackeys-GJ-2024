extends CharacterBody2D
class_name CrabController



@export var crab_health_system : HealthSystem
@onready var crab_sprite: AnimatedSprite2D = $CrabSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var crab_path_to_load : String
var crab_path : Path
var SPEED = 20

const DAMAGE : int = 1

func _ready() -> void:
	crab_path = load(crab_path_to_load)
	crab_health_system.handle_death.connect(play_death_animation)
	crab_health_system.health_change.connect(play_hurt_animation)


func play_hurt_animation() -> void:
	crab_sprite.play("hurt")
	
func get_to_point(point_position : Vector2) -> Vector2:
	var move_vector : Vector2 = ( point_position - global_position).normalized()
	if move_vector.x < 0:
		crab_sprite.flip_h = true
	else:
		crab_sprite.flip_h = false
		
	return move_vector * SPEED
	


func _physics_process(delta: float) -> void:
	if crab_path.points.size() > 0:
		move_and_collide(get_to_point(crab_path.get_point_world_pos(crab_path.points[0])) * delta)
		if (global_position - crab_path.get_point_world_pos(crab_path.points[0])).length() < 1:
			crab_path.points.pop_front()
		
	
func _process(delta: float) -> void:
	if !crab_sprite.is_playing():
		crab_sprite.play("walk")

func play_death_animation() -> void:
	animation_player.play("Death")
	
func _on_attack_area_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		crab_sprite.play("attack")
		area.damage(DAMAGE)
