extends Node2D

var parameteres = {
	"wood": 0,
	"stone": 0,
	"fish": 0,
	"player_pos": null,
	"time": null
}

func cleanup():
	queue_free()

func load_level_data(new: Dictionary):
	parameteres = new
