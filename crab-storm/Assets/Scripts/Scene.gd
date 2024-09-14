extends Node2D

var parameteres = {
	"wood": 0,
	"rock": 0,
	"fish": 0,
	"player_pos": Vector2(10, 10),
	"time": 0
}

func _ready() -> void:
	SignalBus.player_pos_before.emit(parameteres["player_pos"])
	print(parameteres)

func cleanup():
	if self.name == "beach_rave":
		var scene = PackedScene.new()
		scene.pack(self)
		ResourceSaver.save(scene, "res://Stages/Saved.tscn")
	queue_free()

func load_level_data(new: Dictionary):
	parameteres = new


func _on_player_player_position(v: Vector2) -> void:
	parameteres["player_pos"] = v
