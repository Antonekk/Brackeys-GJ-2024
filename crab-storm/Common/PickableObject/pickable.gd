extends Node2D
class_name Pickable

enum PickableState {OnGround, Locked ,Picked, Throw}


@export var impulse : float
var CurrentState : PickableState
var FollowPoint : Node2D
@export var Collider : CollisionShape2D
@export var PickableObject : Node2D
@export var PickableCollision : CollisionShape2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentState  = PickableState.OnGround


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CurrentState == PickableState.Picked:
		PickableObject.global_position = FollowPoint.global_position
		
		 
	
func EnablePickable(body : Node2D) -> void:
	Collider.disabled = true
	CurrentState = PickableState.Picked
	FollowPoint = body
	PickableObject.z_index = 1
	print_debug("PickUp")
	
func DisablePickable(body : Node2D) -> void:
	CurrentState = PickableState.Throw
	Collider.disabled = false
	FollowPoint = null
	PickableObject.z_index = 0
	print_debug("Exit Pickup")
	
	
	
