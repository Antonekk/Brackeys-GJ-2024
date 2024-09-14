extends Node2D

const PATH_LIMIT_NUM : int = 2

var level : int
var can_spawn = true
const MAX_CRAB_COUNT : int = 25

const CRAB = preload("res://Entities/Enemies/Crab/crab.tscn")

var path_to_crabs : String = "res://Entities/Paths/Path{path_num}.tres"

var crabs_count : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#crabs_count = min((level * 4) + randi_range(0,level), MAX_CRAB_COUNT)
	crabs_count = 5

func spawn_crab() -> void:
	var crab_instance = CRAB.instantiate()
	var random_path = randi_range(1,PATH_LIMIT_NUM)
	crab_instance.crab_path_to_load = path_to_crabs.format({"path_num" : random_path})
	self.add_child(crab_instance)
	can_spawn = false
	await get_tree().create_timer(5).timeout
	can_spawn = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_spawn and crabs_count != 0:
		crabs_count-=1
		spawn_crab()
