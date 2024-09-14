extends CharacterBody2D
class_name CrabController

var attack_cooldown : float = 0.46

var currently_in_attack_zone : Array[Area2D]

@export var crab_health_system : HealthSystem
@onready var crab_sprite: AnimatedSprite2D = $CrabSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var current_index : int
var max_index : int
signal has_died

var crab_path_to_load : String
var crab_path : Path
var SPEED = 20

var is_attacking = false

const DAMAGE : int = 1

func _ready() -> void:
	crab_path = load(crab_path_to_load)
	max_index = crab_path.points.size()
	current_index = 0
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
	if current_index != max_index:
		move_and_collide(get_to_point(crab_path.get_point_world_pos(crab_path.points[current_index])) * delta)
		if (global_position - crab_path.get_point_world_pos(crab_path.points[current_index])).length() < 1:
			current_index+=1


func handle_attack_cooldown():
	is_attacking = true
	await get_tree().create_timer(attack_cooldown).timeout
	is_attacking = false
	
func _process(delta: float) -> void:
	if !crab_sprite.is_playing():
		crab_sprite.play("walk")
		
	if currently_in_attack_zone.size() != 0 and !is_attacking:
		crab_sprite.play("attack")
		for enemy in currently_in_attack_zone:	
			enemy.damage(DAMAGE)
		handle_attack_cooldown()

func play_death_animation() -> void:
	has_died.emit()
	animation_player.play("Death")
	


func _on_attack_area_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		currently_in_attack_zone.append(area)


func _on_attack_area_area_exited(area: Area2D) -> void:
	if area is HitboxComponent:
		currently_in_attack_zone.erase(area)
