extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()
signal ryba_clicked

@export var points: Array[Vector2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i = rng.randi_range(0, 2)
	match i:
		0:
			play("ryb1")
		1: 
			play("ryb2")
		2:
			play("ryb3")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("lmb"):
		ryba_clicked.emit()
		queue_free()
