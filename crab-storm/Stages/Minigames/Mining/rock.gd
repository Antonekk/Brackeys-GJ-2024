extends Node2D

var health = 100
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var enabled = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if enabled:		
		if Input.is_action_just_pressed("lmb") or Input.is_action_just_pressed("rmb"):
			health -= 1
		match health:
			100:
				anim.stop()
				anim.play("100%")
			66:
				anim.stop()
				anim.play("66%")
			33:
				anim.stop()
				anim.play("33%")
			0:
				anim.stop()
				anim.play("0%")
				enabled = false
				get_parent().parameteres["rock"] += 6
				SignalBus.level_change.emit("beach_res")
