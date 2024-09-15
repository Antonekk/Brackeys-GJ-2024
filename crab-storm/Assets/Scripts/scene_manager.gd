extends Node2D
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var current_level = $BeachResource
@onready var rich_text_label: RichTextLabel = $OverlayLayer/RichTextLabel

var next_level = null

func _ready() -> void:
	SignalBus.level_change.connect(handle_level_change)
	rich_text_label.get_child(0).start()

func transfer_data(new, old):
	new.load_level_data(old.parameteres)

func handle_level_change(next):
	match next:
		"beach":
			next_level = load("res://Stages/beach_resource.tscn")
			rich_text_label.visible = true
			rich_text_label.get_child(0).start()
		"cutting":
			next_level = load("res://Stages/Minigames/Drzewo/tree_minigame.tscn")
		"beach_res":
			next_level = ResourceLoader.load("res://Stages/Saved.tscn")
		"beach_rav":
			rich_text_label.visible = false
			next_level = load("res://Stages/beach_rave.tscn")
		"fishing":
			next_level = load("res://Stages/Minigames/Fish/fishing_minigame.tscn")
		"mining":
			next_level = load("res://Stages/Minigames/Mining/mining_minigame.tscn")
		"castle":
			next_level = null # dodaj path
		_:
			return
	next_level = next_level.instantiate()
	anim.play("fade_in")
	transfer_data(next_level, current_level)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade_in":
			current_level.cleanup()
			current_level = next_level
			add_child(next_level)
			next_level = null
			anim.play("fade_out")
		"fade_out":
			SignalBus.new_scene_loaded.emit()
		_:
			pass


func _on_timer_timeout() -> void:
	SignalBus.level_change.emit("beach_rav")
