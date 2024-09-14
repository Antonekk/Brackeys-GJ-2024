extends Node2D


var level : int
var can_spawn = true
const MAX_CRAB_COUNT : int = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var crabs_count = min((level * 4) + randi_range(0,level), MAX_CRAB_COUNT)

func spawn_crab() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_spawn:
		spawn_crab()
