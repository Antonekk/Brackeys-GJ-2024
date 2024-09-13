extends Node2D

@export var next_level_name: String = "beach"

func init_level_change():
	SignalBus.level_change.emit(next_level_name)
