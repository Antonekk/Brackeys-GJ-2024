extends CharacterBody2D
class_name PlayerController

@onready var beach_rave: SceneScript = $".."


@export var health_system : HealthSystem
const SPEED = 75.0
const RUN_SPEED = 110.0


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var ammo_count: int

const DODGE_SPEED: float = 300.0
const DODGE_COOLDOWN: float = 5.0
const DODGE_TIME: float = 0.2
var dodge_timer : SceneTreeTimer

const COLLECT_AMMO_TIME: float = 0.5
const BULLET_SPEED  = 200
var Rock_Ammo_Projectile = preload("res://Entities/Projectiles/Rock_Projectile/projectile.tscn")



var is_hurt = false
@onready var picker: Picker = $Picker
@onready var bullet_spawn_point: Marker2D = $BulletSpawnPoint

enum MovementState {IDLE, WALKING, RUNNING}
var CurrentMovementState : MovementState = MovementState.IDLE

enum DodgeState {CAN_DODGE, IS_DODGING ,DODGE_ON_COOLDOWN}
var CurrentDodgingState : DodgeState = DodgeState.CAN_DODGE
signal dodge_on_cooldown
signal dodge_is_up


enum AttackState {EMPTY_AMMO,COLLECTING_AMMO ,HAS_AMMO}
var CurrentAttackState : AttackState = AttackState.EMPTY_AMMO

@onready var dodge: AudioStreamPlayer2D = $Dodge


var dodge_direction:Vector2

@onready var player_sprite: AnimatedSprite2D = $AnimatedSprite2D
signal player_position(v: Vector2)

func _ready() -> void:
	ammo_count = max(beach_rave.parameteres["castle"]["fishlvl"], 1)
	health_system.health_change.connect(play_hurt_anim)

# function for handling dodging logic
func handle_dodge_cooldowns() -> void:
	collision_mask = 0b001
	CurrentDodgingState = DodgeState.IS_DODGING
	dodge.play()
	await get_tree().create_timer(DODGE_TIME).timeout
	dodge_on_cooldown.emit()
	print("DODGE ENDED")
	collision_mask = 0b101
	CurrentDodgingState = DodgeState.DODGE_ON_COOLDOWN
	dodge_timer = get_tree().create_timer(DODGE_COOLDOWN)
	await dodge_timer.timeout
	dodge_is_up.emit()
	print("DODGE IS UP")
	CurrentDodgingState = DodgeState.CAN_DODGE
	
func handle_ammo_pickup() -> void:
	CurrentAttackState = AttackState.COLLECTING_AMMO
	print("COLLECTING")
	await get_tree().create_timer(COLLECT_AMMO_TIME).timeout 
	print("COLLECTED")
	CurrentAttackState = AttackState.HAS_AMMO
	
	
func handle_shooting_projectile() -> void:
	CurrentAttackState = AttackState.EMPTY_AMMO
	for i in ammo_count:
		var ammo_instance : RigidBody2D = Rock_Ammo_Projectile.instantiate()
		ammo_instance.position = bullet_spawn_point.global_position
		
		var vect = (get_global_mouse_position() - bullet_spawn_point.global_position).normalized()
		ammo_instance.apply_impulse(vect*BULLET_SPEED, Vector2(0,0))
		get_tree().root.add_child(ammo_instance)
		await get_tree().create_timer(0.1).timeout
		
	
	
#handle player movement
func movement() -> void:
	
	if CurrentAttackState == AttackState.COLLECTING_AMMO:
		velocity = Vector2(0,0)
	else:
		var is_running := Input.is_action_pressed("Run")
		var dodge_input := Input.is_action_pressed("Dodge")
		# Get input direction -1, 0, 1 depending on input
		var direction_horizontal := Input.get_axis("Move_Left", "Move_Right")
		var direction_vertical := Input.get_axis("Move_Up", "Move_Down")
		
		#Create direction vector
		var direction2D := Vector2(direction_horizontal, direction_vertical)
		
		# Normalize the direction vector if it's not zero
		if direction2D.length() > 0:
			direction2D = direction2D.normalized()
		
		# Handle sprite fliping
		if direction_horizontal != 0:
				player_sprite.flip_h = direction_horizontal > 0
				
		if dodge_input and CurrentDodgingState == DodgeState.CAN_DODGE and picker.CurrentPickerState == picker.PickerState.Empty and CurrentAttackState != AttackState.COLLECTING_AMMO:
			dodge_direction = direction2D
			handle_dodge_cooldowns()
			
		if CurrentDodgingState == DodgeState.IS_DODGING:
			velocity = dodge_direction * DODGE_SPEED
		else :
			# Set velocity based on the normalized direction
			var movement_multiplier := SPEED if !is_running else RUN_SPEED
			velocity = direction2D * movement_multiplier
	
		if direction2D == Vector2.ZERO:
			CurrentMovementState = MovementState.IDLE
		elif is_running:
			CurrentMovementState = MovementState.RUNNING
		else:
			CurrentMovementState = MovementState.WALKING

func pickup() -> void:
	var pickup_input := Input.is_action_just_pressed("Pickup")
	if pickup_input:
		if picker.CurrentPickerState == picker.PickerState.Empty and CurrentAttackState != AttackState.COLLECTING_AMMO and CurrentDodgingState!= DodgeState.IS_DODGING:
			picker.pickup()
		elif picker.CurrentPickerState == picker.PickerState.Picked :
			picker.throw()
	
func shooting() -> void:
	var shoot_input := Input.is_action_just_pressed("Shoot")
	#handle shooting logic
	if picker.CurrentPickerState == picker.PickerState.Empty and CurrentDodgingState!= DodgeState.IS_DODGING:
		if shoot_input and CurrentAttackState == AttackState.EMPTY_AMMO:
			handle_ammo_pickup()	
		elif shoot_input and CurrentAttackState == AttackState.HAS_AMMO:
			handle_shooting_projectile()


func _physics_process(delta: float) -> void:
	
	shooting()
	pickup()
	movement()
	# Move the player using the velocity
	move_and_slide()
	player_position.emit(position)

func _process(delta: float) -> void:
	var current_animation = player_sprite.animation
	if is_hurt:
		player_sprite.play("hurt")
		return
	if CurrentDodgingState != DodgeState.IS_DODGING and CurrentAttackState != AttackState.COLLECTING_AMMO:
		if CurrentMovementState == MovementState.WALKING and current_animation != "walk":
			player_sprite.play("walk")
		if CurrentMovementState == MovementState.IDLE and current_animation != "idle":
			player_sprite.play("idle")
		if CurrentMovementState == MovementState.RUNNING and current_animation != "run":
			player_sprite.play("run")
	elif CurrentDodgingState == DodgeState.IS_DODGING and current_animation != "dodge":
		player_sprite.play("dodge")
	if CurrentAttackState == AttackState.COLLECTING_AMMO and current_animation!="ammo_pickup":
		player_sprite.play("ammo_pickup")
		audio_stream_player.play()
		


func play_hurt_anim() -> void:
	is_hurt = true
	player_sprite.play("hurt")
	await get_tree().create_timer(0.28).timeout
	is_hurt = false
