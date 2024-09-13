extends Node2D

var parameteres = {
	"wood": 0,
	"stone": 0,
	"fish": 0,
	"player_pos": Vector2(0, 0),
	"time": 0
}

func cleanup():
	queue_free()

func load_level_data(new: Dictionary):
	parameteres = new
