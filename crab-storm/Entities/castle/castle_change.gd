extends Node2D
class_name CastleChange


var can_enter : bool

@export var Castles : Array[Node2D]
@export var Flags : Array[Node2D]

var max_castle_lvl : int
var current_castle_lvl : int


var max_flag_lvl : int
var current_flag_lvl : int


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
