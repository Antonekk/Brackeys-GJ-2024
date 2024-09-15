extends CanvasLayer

var parameteres = {
	"wood": 0,
	"rock": 0,
	"fish": 0,
	"crab": 0,
	"time": 0,
	"castle": {"rocklvl": 0, "woodlvl": 0, "fishlvl": 0, "crablvl" : 0},
	"lvl" : 0
}

func cleanup():
	if self.name == "BeachResource":
		var scene = PackedScene.new()
		scene.pack(self)
		ResourceSaver.save(scene, "res://Stages/Saved.tscn")
	queue_free()

func load_level_data(new: Dictionary):
	parameteres = new

func _on_button_pressed() -> void:
	SignalBus.level_change.emit("beach")
