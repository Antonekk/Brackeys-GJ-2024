extends Sprite2D

@onready var lvl: Label = $lvl
@onready var needed: Label = $needed
@onready var castle_inside: SceneScript = $".."
@onready var label: Label = $"../CanvasLayer/Label"

var needed_for_levels : Array[int] = [5,15,25]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lvl.text = "lvl: " + str(castle_inside.parameteres["castle"]["fishlvl"])
	if castle_inside.parameteres["castle"]["fishlvl"] != 3:
		needed.text = str(castle_inside.parameteres["fish"]) + " / " + str(needed_for_levels[castle_inside.parameteres["castle"]["fishlvl"]])
	else:
		needed.text = "max level"


func _on_interact_area_area_entered(area: Area2D) -> void:
	label.text = "upgrade: pickup more stones"


func _on_interact_area_area_exited(area: Area2D) -> void:
	label.text = ""
