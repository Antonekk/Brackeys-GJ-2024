extends TextureRect



@onready var player: PlayerController = $"../../Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.dodge_is_up.connect(icon_show)
	player.dodge_on_cooldown.connect(icon_hide)


func icon_hide():
	visible = false
	
func icon_show():
	visible = true
