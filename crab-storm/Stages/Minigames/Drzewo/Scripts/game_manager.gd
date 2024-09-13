extends Node

const DRZEWO_TEMP = preload("res://Stages/Minigames/Drzewo/Scenes/drzewo_z_gal.tscn")
@onready var gura: Sprite2D = $Gura
var enabled: bool = true

var tree = []
var rng = RandomNumberGenerator.new()
var current = 0
var height
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	height = rng.randi_range(5, 7)
	for i in range(height):
		var rand = rng.randi_range(0, 1)
		print(i)
		var block = DRZEWO_TEMP.instantiate()
		tree.append(block)
		add_child(block)
		block.position.y -= i * 16 - 8 + 16
		block.flip_h = bool(rand)
		if !rand:
			block.position.x -= 16
	gura.position.y -= height * 16 - 8 + 16
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enabled:
		if current == height:
			finish(score)
		if Input.is_action_just_pressed("rmb"):
			if !tree[current].flip_h:
				print("good")
				score += 1
			else:
				finish(score)
				print("bad")
			tree[current].queue_free()
			current += 1
			for i in range(current, height):
				tree[i].position.y += 16
			gura.position.y += 16
		elif Input.is_action_just_pressed("lmb"):
			if tree[current].flip_h:
				score += 1
				print("good")
			else:
				finish(score)
				print("bad")
			tree[current].queue_free()
			current += 1
			for i in range(current, height):
				tree[i].position.y += 16 
			gura.position.y += 16

func finish(score: int) -> void:
	enabled = false
	SignalBus.level_change.emit("beach")
