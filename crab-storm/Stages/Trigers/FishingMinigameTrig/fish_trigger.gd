extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		SignalBus.level_change.emit("fishing")
		await get_tree().create_timer(0.7).timeout
		get_parent().queue_free()
