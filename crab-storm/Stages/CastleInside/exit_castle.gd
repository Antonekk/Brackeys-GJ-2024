extends Area2D



@onready var castle_inside: SceneScript = $".."



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if castle_inside.parameteres["castle"]["rocklvl"] == 3 and castle_inside.parameteres["castle"]["crablvl"]:
			print("yes")
			SignalBus.level_change.emit("end")
		if castle_inside.parameteres["phase"] == 0:
			SignalBus.level_change.emit("beach_rav")
		else:
			SignalBus.level_change.emit("beach")
