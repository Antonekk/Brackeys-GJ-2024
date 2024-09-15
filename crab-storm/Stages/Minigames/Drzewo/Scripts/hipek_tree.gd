extends CharacterBody2D

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var enabled: bool = true
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"


func _ready() -> void:
	position.x = -20
	position.y = 5
	sprite_2d.flip_h = true
	SignalBus.level_change.connect(level_change)

func _process(delta: float) -> void:
	if enabled:
		if Input.is_action_just_pressed("lmb"):
			position.x = -20
			sprite_2d.flip_h = true
			sprite_2d.stop()
			sprite_2d.play("chop")
			audio_stream_player.play()
		elif Input.is_action_just_pressed("rmb"):
			position.x = 20
			sprite_2d.flip_h = false
			sprite_2d.stop()
			sprite_2d.play("chop")
			audio_stream_player.play()

func level_change(temp):
		enabled = false
