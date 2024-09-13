extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
var enabled: bool = true

func _ready() -> void:
	position.x = -20
	position.y = 5
	sprite_2d.flip_h = true
	SignalBus.level_change.connect(level_change)
	
func level_change(temp):
		enabled = false

func _process(delta: float) -> void:
	if enabled:
		if Input.is_action_just_pressed("lmb"):
			position.x = -20
			sprite_2d.flip_h = true
		elif Input.is_action_just_pressed("rmb"):
			position.x = 20
			sprite_2d.flip_h = false
