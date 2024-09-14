extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()

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
