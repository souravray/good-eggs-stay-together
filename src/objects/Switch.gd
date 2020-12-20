extends Area2D
var state = true 
signal swich_state
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Off" or  anim_name == "First":
		state = false
	else:
		state = true	
	emit_signal("swich_state", state)


func _on_Switch_body_entered(body):
	if body.has_method("get_x_acc") and !state:
		$AnimationPlayer.play("On")
	elif body.has_method("get_x_acc") and state:
		$AnimationPlayer.play("Off")
