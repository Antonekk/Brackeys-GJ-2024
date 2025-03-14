extends Node2D


@onready var player: PlayerController = $"../Player"

var crab_spawn_ended : bool = false
var has_player_won : bool = false
@onready var beach_rave: SceneScript = $".."
@onready var animation_player: AnimationPlayer = $"../CanvasLayer/Label/AnimationPlayer"
@onready var crab_factory: CrabFactory = $"../CrabFactory"
@onready var castle: CastleChange = $"../Castle"
signal castle_enter()
@onready var rocks: Control = $"../CanvasLayer/Rocks"


func change_to_endgame():
	SignalBus.level_change.emit("end_sad")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rocks_indicators = rocks.get_children()
	rocks_indicators[0].visible = true
	for i in range(1,beach_rave.parameteres["castle"]["fishlvl"]):
		rocks_indicators[i].visible = true
	
	player.health_system.handle_death.connect(change_to_endgame)
	castle.health_system.handle_death.connect(change_to_endgame)
	animation_player.play("rave_is_comming")
	crab_factory.crab_kill.connect(add_resource_on_crab_kill)
	crab_factory.has_ended_spawning.connect(set_spawn_ended_flag)
	castle.change_castle_state(beach_rave.parameteres["castle"]["rocklvl"],beach_rave.parameteres["castle"]["crablvl"] )

func add_resource_on_crab_kill():
	beach_rave.parameteres["crab"] += 1
	print(beach_rave.parameteres["crab"])

func set_spawn_ended_flag():
	crab_spawn_ended = true
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if crab_spawn_ended:
		if crab_factory.get_child_count() == 0 and has_player_won != true:
			has_player_won = true
			castle_enter.emit()
			animation_player.play("return_to_castle")
