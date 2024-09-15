extends Sprite2D

@onready var castle_inside: SceneScript = $".."
@onready var lvl: Label = $lvl
@onready var needed: Label = $needed
@onready var label: Label = $"../CanvasLayer/Label"

var needed_for_levels : Array[int] = [5,15,25]


func change_labels() -> void:
	lvl.text = "lvl: " + str(castle_inside.parameteres["castle"]["rocklvl"])
	if castle_inside.parameteres["castle"]["rocklvl"] != 3:
		needed.text = str(castle_inside.parameteres["rock"]) + " / " + str(needed_for_levels[castle_inside.parameteres["castle"]["rocklvl"]])
	else:
		needed.text = "max level"
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_labels()

func _on_interact_area_area_entered(area: Area2D) -> void:
	if castle_inside.parameteres["castle"]["rocklvl"] < 3:
		if castle_inside.parameteres["rock"] >= needed_for_levels[castle_inside.parameteres["castle"]["rocklvl"]]:
			castle_inside.parameteres["rock"] -= needed_for_levels[castle_inside.parameteres["castle"]["rocklvl"]]
			castle_inside.parameteres["castle"]["rocklvl"] += 1
			change_labels()
		
	label.text = "upgrade: bigger castle"


func _on_interact_area_area_exited(area: Area2D) -> void:
	label.text = ""
