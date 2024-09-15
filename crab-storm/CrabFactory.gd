extends Node2D
class_name CrabFactory

const PATH_LIMIT_NUM : int = 6
@onready var beach_rave: SceneScript = $".."

var level : int
const MAX_CRAB_COUNT : int = 50

const CRAB = preload("res://Entities/Enemies/Crab/crab.tscn")

var path_to_crabs : String = "res://Entities/Paths/Path{path_num}.tres"

var crabs_count : int

var killed_crabs : int = 0

signal has_ended_spawning
signal crab_kill

func add_killed_crab() -> void:
	killed_crabs += 1
	crab_kill.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = beach_rave.parameteres["lvl"]
	crabs_count = min(((level+1) * 4) + randi_range(1,(level*2 )), MAX_CRAB_COUNT)
	spawn_crab()

func spawn_crab() -> void:
	for i in crabs_count:
		var crab_instance = CRAB.instantiate()
		crab_instance.has_died.connect(add_killed_crab)
		var random_path = randi_range(1,PATH_LIMIT_NUM)
		crab_instance.crab_path_to_load = path_to_crabs.format({"path_num" : random_path})
		self.add_child(crab_instance)
		await get_tree().create_timer(randf_range(3,5)).timeout
	has_ended_spawning.emit()
	
		
	
