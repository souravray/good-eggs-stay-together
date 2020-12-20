extends KinematicBody2D
signal on_death
signal game_over
class_name Actor
export var speed: = Vector2(150.0,150.0)
export var gravity: = 300.0
var selected = false 
var _velocity: = Vector2.ZERO
var _is_dead := false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_action_strength(action: String) -> float:
	if !selected:
		return 0.0
	else:
		return Input.get_action_strength(action)

func select(selection): 
	selected = selection
	if get_node("Light2D"):
		get_node("Light2D").set_enabled(selection)
	
func  is_action_just_released(action: String) -> bool:
	if !selected:
		return false
	else:
		return Input.is_action_just_released(action)
		
func is_action_just_pressed(action: String) -> bool:
	if !selected:
		return false
	else:
		return Input.is_action_just_pressed(action)
		
func is_action_pressed(action: String) -> bool:
	if !selected:
		return false
	else:
		return Input.is_action_pressed(action)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func die():
	_is_dead = true
	emit_signal("on_death")
