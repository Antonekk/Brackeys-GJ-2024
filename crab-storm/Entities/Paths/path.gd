extends Resource
class_name Path

@export var points : Array[Vector2]

func get_point_world_pos(point :Vector2) -> Vector2:
	return point * 16
