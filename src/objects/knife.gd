extends StaticBody2D

signal dead
export var turn = 90.0
var _turn = 0
var killed_body = ''
var _rotating :bool
var _direction = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_rotating = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if _rotating:
		var rotation  = get_rotation_degrees()
		print(get_rotation_degrees())
		if _direction > 0  and _turn > 0.0:
			rotation += 90.0*delta
			_turn -= 90.0*delta
			set_rotation_degrees(rotation)
		elif _direction < 0  and _turn > 0.0:
			rotation -= 90.0*delta
			_turn -= 90.0*delta
			set_rotation_degrees(rotation)
		else:
			_rotating =  false

func rotate_down():
	if !_rotating:
		_rotating = true
		_direction =  -1
		_turn = turn

func rotate_up():
	if !_rotating:
		_rotating = true
		_direction =  1
		_turn = turn


func _on_Area2D_body_entered(body):
	if body.has_method("get_x_acc") :
		if killed_body != body.get_name():
			killed_body = body.get_name()
			emit_signal("dead", killed_body)
