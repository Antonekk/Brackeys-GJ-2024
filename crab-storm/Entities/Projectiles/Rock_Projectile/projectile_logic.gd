extends RigidBody2D


const DAMAGE : int = 2
const UP_TIME : float = 1


func handle_up_time() -> void:
	await get_tree().create_timer(UP_TIME).timeout
	queue_free()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handle_up_time()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		area.damage(DAMAGE)
		queue_free()
	else:
		queue_free()
