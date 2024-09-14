extends AnimatedSprite2D


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("lmb") or Input.is_action_just_pressed("rmb"):
		stop()
		play("kilof")
