extends Node2D

@onready var beach_rave: SceneScript = $".."
const ROCK = preload("res://Entities/Pickable/Rock/rock.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level = beach_rave.parameteres["castle"]["woodlvl"]
	var markers = get_children()
	for i in level:
		var inst = ROCK.instantiate()
		inst.global_position = markers[i].global_position
		add_child(inst)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
