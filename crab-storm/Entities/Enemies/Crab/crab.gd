extends CharacterBody2D


var Path : Array = [Vector2(0,0), Vector2(0,-50), Vector2(-50,-50)]
var SPEED = 10

func get_to_point(point_position : Vector2) -> Vector2:
	var move_vector : Vector2 = ( point_position - global_position).normalized()
	return move_vector * SPEED
	


func _physics_process(delta: float) -> void:
	if Path.size() > 0:
		move_and_collide(get_to_point(Path[0]) * delta)
		if (global_position - Path[0]).length() < 1:
			print("POINT")
			Path.pop_front()
		
	
