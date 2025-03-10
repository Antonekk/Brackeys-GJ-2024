extends Sprite2D

@onready var castle_inside: SceneScript = $".."
@onready var lvl: Label = $lvl
@onready var needed: Label = $needed
@onready var label: Label = $"../CanvasLayer/Label"



var needed_for_levels : Array[int] = [5,15,25]
@onready var upgrade: AudioStreamPlayer = $"../Upgrade"


func change_labels() -> void:
	lvl.text = "lvl: " + str(castle_inside.parameteres["castle"]["crablvl"])
	if castle_inside.parameteres["castle"]["crablvl"] != 3:
		needed.text = str(castle_inside.parameteres["crab"]) + " / " + str(needed_for_levels[castle_inside.parameteres["castle"]["crablvl"]])
	else:
		needed.text = "max level"
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_labels()


func _on_interact_area_area_entered(area: Area2D) -> void:
	if castle_inside.parameteres["castle"]["crablvl"] < 3:
		if castle_inside.parameteres["crab"] >= needed_for_levels[castle_inside.parameteres["castle"]["crablvl"]]:
			castle_inside.parameteres["crab"] -= needed_for_levels[castle_inside.parameteres["castle"]["crablvl"]]
			castle_inside.parameteres["castle"]["crablvl"] += 1
			upgrade.play()
			change_labels()
	
	label.text = "upgrade: castle flag (win condition)"


func _on_interact_area_area_exited(area: Area2D) -> void:
	label.text = ""
