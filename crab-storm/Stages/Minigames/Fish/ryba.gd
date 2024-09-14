extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()
signal ryba_clicked(Node2D)
var start : Vector2
var end : Vector2
var p = 0

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
func _physics_process(delta: float) -> void:
	if p == 0:
		if (end - position).x < 0:
			flip_h = false
		else:
			flip_h = true
		position += (end - position).normalized() * delta * 15
		if (position - end).length() < 1:
			p = 1
	elif p == 1:
		if (start - position).x < 0:
			flip_h = false
		else:
			flip_h = true
		position += (start - position).normalized() * delta * 15
		if (position - start).length() < 1:
			p = 0


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("lmb"):
		ryba_clicked.emit(self)
