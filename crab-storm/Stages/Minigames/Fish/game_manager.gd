extends Node2D

const ryba = preload("res://Stages/Minigames/Fish/ryba.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	var dummy_ryba = ryba.instantiate()
	dummy_ryba.points.shuffle()
	for i in range(rng.randi_range(5, 7)):
		var temp = ryba.instantiate()
		temp.ryba_clicked.connect(Click)
		add_child(temp)
		temp.position = dummy_ryba.points[i]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Click():
	print("click")
