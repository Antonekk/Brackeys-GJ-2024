extends CharacterBody2D


const SPEED = 75.0
const RUN_SPEED = 110.0


const DODGE_SPEED: float = 200.0
const DODGE_COOLDOWN: float = 5.0
const DODGE_TIME: float = 0.2


enum DodgeState {CAN_DODGE, IS_DODGING ,DODGE_ON_COOLDOWN}

var CurrentDodgingState : DodgeState = DodgeState.CAN_DODGE

var dodge_direction:Vector2

@onready var player_sprite: Sprite2D = $Sprite2D


# function for handling dodging logic
func handle_dodge_cooldowns() -> void:
	CurrentDodgingState = DodgeState.IS_DODGING
	await get_tree().create_timer(DODGE_TIME).timeout
	print("DODGE ENDED")
	CurrentDodgingState = DodgeState.DODGE_ON_COOLDOWN
	await get_tree().create_timer(DODGE_COOLDOWN).timeout
	print("DODGE IS UP")
	CurrentDodgingState = DodgeState.CAN_DODGE
	
	
	
	


func _physics_process(delta: float) -> void:
	
	# Get input direction -1, 0, 1 depending on input
	var direction_horizontal := Input.get_axis("Move_Left", "Move_Right")
	var direction_vertical := Input.get_axis("Move_Up", "Move_Down")
	var is_running := Input.is_action_pressed("Run")
	var dodge_input := Input.is_action_pressed("Dodge")

	 # Create a direction vector from the input
	var direction2D := Vector2(direction_horizontal, direction_vertical)
	
	# Normalize the direction vector if it's not zero
	if direction2D.length() > 0:
		direction2D = direction2D.normalized()
	
	# Handle sprite fliping
	if direction_horizontal != 0:
		player_sprite.flip_h = direction_horizontal > 0
		
	if dodge_input and CurrentDodgingState == DodgeState.CAN_DODGE:
		dodge_direction = direction2D
		handle_dodge_cooldowns()
		
	if CurrentDodgingState == DodgeState.IS_DODGING:
		velocity = dodge_direction * DODGE_SPEED
	else :
		# Set velocity based on the normalized direction
		var movement_multiplier := SPEED if !is_running else RUN_SPEED
		velocity = direction2D * movement_multiplier
	
		

	# Move the player using the velocity
	move_and_slide()
