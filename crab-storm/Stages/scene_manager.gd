extends Node2D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var current_level = $Tree_Minigame
var next_level = null

func _ready() -> void:
	SignalBus.level_change.connect(handle_level_change)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func handle_level_change(next):
	match next:
		"TreeMinigame":
			next_level = load("res://Stages/Minigames/Drzewo/tree_minigame.tscn")
		"beach":
			next_level = load("res://Stages/beach.tscn")
		_:
			return
	next_level = next_level.instantiate()
	anim.play("fade_in")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade_in":
			current_level.cleanup()
			current_level = next_level
			add_child(next_level)
			next_level = null
			anim.play("fade_out")
		"fade_out":
			pass
		_:
			pass
