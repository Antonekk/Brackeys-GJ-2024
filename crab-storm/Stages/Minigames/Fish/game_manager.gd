extends Node2D

const ryba = preload("res://Stages/Minigames/Fish/ryba.tscn")
var rng = RandomNumberGenerator.new()
var ryba_max
var points = 0
var fish_clicked = false
var enabled = true
@onready var scene: Node2D = $".."
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	points = 0
	rng.randomize()
	var dummy_ryba = ryba.instantiate()
	ryba_max = rng.randi_range(5, 7)
	dummy_ryba.points.shuffle()
	for i in range(0, 2 * ryba_max, 2):
		var temp = ryba.instantiate()
		temp.ryba_clicked.connect(Click)
		add_child(temp)
		temp.position = dummy_ryba.points[i]
		temp.start = dummy_ryba.points[i]
		temp.end = dummy_ryba.points[i+1]
	dummy_ryba.queue_free()

func Click(fish):
	if enabled:
		audio_stream_player.play()
		fish.queue_free()
		points += 1
		fish_clicked = true
		if points == ryba_max:
			enabled = false
			scene.parameteres["fish"] += points
			SignalBus.level_change.emit("beach_res")
			print("swap")
			
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("lmb") and !fish_clicked:
		scene.parameteres["fish"] += points
		SignalBus.level_change.emit("beach_res")
		enabled = false
	fish_clicked = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
