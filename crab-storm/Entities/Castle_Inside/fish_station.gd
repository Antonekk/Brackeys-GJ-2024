extends Sprite2D

@onready var lvl: Label = $lvl
@onready var needed: Label = $needed
@onready var castle_inside: SceneScript = $".."
@onready var label: Label = $"../CanvasLayer/Label"

var needed_for_levels : Array[int] = [5,15,25]

func change_labels():
	lvl.text = "lvl: " + str(castle_inside.parameteres["castle"]["fishlvl"])
	if castle_inside.parameteres["castle"]["fishlvl"] != 3:
		needed.text = str(castle_inside.parameteres["fish"]) + " / " + str(needed_for_levels[castle_inside.parameteres["castle"]["fishlvl"]])
	else:
		needed.text = "max level"
		
		
func _ready() -> void:
	change_labels()
	


func _on_interact_area_area_entered(area: Area2D) -> void:
	if castle_inside.parameteres["castle"]["fishlvl"] < 3:
		if castle_inside.parameteres["fish"] >= needed_for_levels[castle_inside.parameteres["castle"]["fishlvl"]]:
			castle_inside.parameteres["fish"] -= needed_for_levels[castle_inside.parameteres["castle"]["fishlvl"]]
			castle_inside.parameteres["castle"]["fishlvl"] += 1
			change_labels()
	
	label.text = "upgrade: pickup more stones"


func _on_interact_area_area_exited(area: Area2D) -> void:
	label.text = ""
