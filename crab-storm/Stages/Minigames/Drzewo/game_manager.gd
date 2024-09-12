extends Node

@onready var static_body_2d: StaticBody2D = $"../StaticBody2D"
const BEACH = preload("res://Stages/beach.tscn")
const DRZEWO_TEMP = preload("res://Stages/Minigames/Drzewo/drzewo temp.tscn")

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
		block.position.y -= i * 32
		block.get_child(0).flip_h = bool(rand)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current == height:
		finish(score)	
	if Input.is_action_just_pressed("lmb"):
		if !tree[current].get_child(0).flip_h:
			print("good")
			score += 1
		else:
			finish(score)
			print("bad")
		tree[current].queue_free()
		current += 1
		for i in range(current, height):
			tree[i].position.y += 32
	elif Input.is_action_just_pressed("rmb"):
		if tree[current].get_child(0).flip_h:
			score += 1
			print("good")
		else:
			finish(score)
			print("bad")
		tree[current].queue_free()
		current += 1
		for i in range(current, height):
			tree[i].position.y += 32

func finish(score: int) -> void:
	#przekaz ilosc punktow
	get_tree().change_scene_to_packed(BEACH)
