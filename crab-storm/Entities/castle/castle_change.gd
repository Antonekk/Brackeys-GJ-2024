extends Node2D
class_name CastleChange

var enable = false
var can_enter : bool

@export var Castles : Array[Node2D]
@export var Flags : Array[Node2D]

var max_castle_lvl : int
var current_castle_lvl : int
@onready var health_system: HealthSystem = $HealthSystem


var max_flag_lvl : int
var current_flag_lvl : int
@onready var beach_rave: SceneScript = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_castle_lvl = Castles.size()
	max_flag_lvl = Flags.size()
	
	current_castle_lvl = 0
	current_flag_lvl = 0
	Castles[current_castle_lvl].visible = true
	Flags[current_flag_lvl].visible = true
	


func change_castle_state(castle_lvl: int, flag_lvl: int):
	if castle_lvl < max_castle_lvl and flag_lvl < max_flag_lvl:
		Castles[current_castle_lvl].visible = false
		Flags[current_flag_lvl].visible = false
		
		current_castle_lvl =  castle_lvl
		current_flag_lvl = flag_lvl
		
		Castles[current_castle_lvl].visible = true
		Flags[current_flag_lvl].visible = true


func _on_entry_body_entered(body: Node2D) -> void:
	print("entered")
	if enable:
		beach_rave.parameteres["phase"] = 1
		beach_rave.parameteres["lvl"] += 1
		SignalBus.level_change.emit("castle")


func _on_crab_rave_manager_castle_enter() -> void:
	enable = true
