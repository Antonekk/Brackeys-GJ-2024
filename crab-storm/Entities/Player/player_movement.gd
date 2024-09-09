extends CharacterBody2D


const SPEED = 75.0
const RUN_SPEED = 110.0
const DODGE_SPEED = 200.0
const DODGE_TIME = 0.5

var is_dodging: bool = false

@onready var player_sprite: Sprite2D = $Sprite2D


func handle_dodge(delta: float) -> void:
	pass
	
	


func _physics_process(delta: float) -> void:
	
	# Get input direction -1, 0, 1 depending on input
	var direction_horizontal := Input.get_axis("Move_Left", "Move_Right")
	var direction_vertical := Input.get_axis("Move_Up", "Move_Down")
	var is_running := Input.is_action_pressed("Run")

	
	 # Create a direction vector from the input
	var direction2D = Vector2(direction_horizontal, direction_vertical)
	
	# Normalize the direction vector if it's not zero
	if direction2D.length() > 0:
		direction2D = direction2D.normalized()
	
	# Set velocity based on the normalized direction
	var movement_multiplier = SPEED if !is_running else RUN_SPEED
	velocity = direction2D * movement_multiplier
	
	

	# Handle sprite fliping
	if direction_horizontal != 0:
		player_sprite.flip_h = direction_horizontal > 0

	# Move the player using the velocity
	move_and_slide()
