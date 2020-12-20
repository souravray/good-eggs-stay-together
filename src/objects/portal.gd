tool
extends Area2D
export var next_sceen: PackedScene
signal playes_at_base
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var body_hash = -1

func _get_configuration_warning():
	return "No next sceen" if not next_sceen else ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var body_count = 0
	var overlapingBodies = get_overlapping_bodies()
	var body_names = []
	for i in range(0, overlapingBodies.size()):
		var body = overlapingBodies[i]
		if body.has_method("get_x_acc"):
			body_names.push_front(body.get_name())

	if body_names.hash() != body_hash:
		body_hash = body_names.hash()
		emit_signal("playes_at_base", body_names)

func teleport():
	anim_player.play("FADE_IN")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_sceen)
	
func reload():
	print("HEREHERE")
	anim_player.play("FADE_IN")
	yield(anim_player, "animation_finished")
	get_tree().reload_current_scene()
