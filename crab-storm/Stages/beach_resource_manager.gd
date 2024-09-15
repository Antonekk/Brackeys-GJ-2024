extends Node2D

@onready var beach_resource: SceneScript = $".."
@onready var castle: CastleChange = $"../Castle"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	castle.change_castle_state(beach_resource.parameteres["castle"]["rocklvl"],beach_resource.parameteres["castle"]["crablvl"])
	
func _process(delta: float) -> void:
	pass
