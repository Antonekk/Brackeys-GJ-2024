extends CharacterBody2D


var crab_path : Path = load("res://Entities/Paths/Path2.tres")
var SPEED = 20

func get_to_point(point_position : Vector2) -> Vector2:
	var move_vector : Vector2 = ( point_position - global_position).normalized()
	return move_vector * SPEED
	


func _physics_process(delta: float) -> void:
	if crab_path.points.size() > 0:
		move_and_collide(get_to_point(crab_path.get_point_world_pos(crab_path.points[0])) * delta)
		if (global_position - crab_path.get_point_world_pos(crab_path.points[0])).length() < 1:
			crab_path.points.pop_front()
		
	
