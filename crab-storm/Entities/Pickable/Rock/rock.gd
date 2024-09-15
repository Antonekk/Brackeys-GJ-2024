extends StaticBody2D

@onready var health_system: HealthSystem = $HealthSystem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_system.handle_death.connect(death)

func death() -> void:
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
