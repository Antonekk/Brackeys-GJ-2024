extends Node2D
class_name SceneScript

var parameteres = {
	"wood": 0,
	"rock": 0,
	"fish": 0,
	"crab": 0,
	"castle": {"rocklvl": 0, "woodlvl": 0, "fishlvl": 0, "crablvl" : 0},
	"lvl" : 0,
	"phase": 0
}

func _ready() -> void:
	print(parameteres)

func cleanup():
	if self.name == "beach_resource":
		var scene = PackedScene.new()
		scene.pack(self)
		ResourceSaver.save(scene, "res://Stages/Saved.tscn")
	queue_free()

func load_level_data(new: Dictionary):
	parameteres = new
