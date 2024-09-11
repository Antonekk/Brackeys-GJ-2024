extends Node2D
class_name Picker


#Although lists aren't opt with delete operations, in reality there won't be many items in it (max. 2-3)
var Pickables : Array = []
enum PickerState {Empty, Picked}
var CurrentPickerState : PickerState = PickerState.Empty

@export var placement : Marker2D
@export var pickup_area : Area2D
@export var holder : Node2D

var pickable_holded : Pickable
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pickup_area.body_entered.connect(add_pickables)
	pickup_area.body_exited.connect(remove_pickables)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func pickup() -> void:
	var target = holder.transform.get_origin()
	var closest_node: Node2D = null
	var min_distance: float = INF  # Start with a very large number
	if Pickables.size() > 0:
		for node in Pickables:
			var distance = target.distance_to(node.transform.get_origin())
			if distance < min_distance:
				min_distance = distance
				closest_node = node
	
		closest_node = closest_node.get_node("Pickable")
		if closest_node is Pickable:
			var pickable_node : Pickable = closest_node
			pickable_holded = pickable_node
			pickable_node.EnablePickable(placement)
			CurrentPickerState = PickerState.Picked 

func throw() -> void:
	CurrentPickerState = PickerState.Empty 
	pickable_holded.DisablePickable(placement)
	
func add_pickables(body : Node2D) -> void:
	if body not in Pickables:
		Pickables.append(body)
		

func remove_pickables(body : Node2D) -> void:
	if body in Pickables:
		Pickables.erase(body)
