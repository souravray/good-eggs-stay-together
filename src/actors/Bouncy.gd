extends "res://src/actors/actor.gd"

var x_acc_rate = 100.0
var y_acc_rate = 50.0
var prev_velocity =  Vector2.ZERO 
export var max_x = 180.0 

# floaty m_x:220 s: { 140, 400} G: 305
# bouncy m_x:200 s: { 150, 370} G: 300
var killCount = 0
var max_y = 300.0
var is_jumping = false
var poewer_up = true
var bounce_count = 0
var is_hopping = false
var puff_count = 0
var hit_pos
var tilemap
var tile_pos

func _physics_process(delta: float) -> void:
	if !_is_dead:
	#	var direction: = get_direction()
	#	var is_jump_interrupted: = is_action_just_pressed("jump") and _velocity.y < 0.0
		var x_acc = get_x_acc()
		var y_acc = get_y_acc()
		var direction: = get_direction()
		
		if is_on_wall() and ($LeftCast.is_colliding() or $RightCast.is_colliding()):
			if !poewer_up and  get_action_strength("power") > 0.0:
				poewer_up = true
				bounce_count = 1
			var bounce_f_y = 1.7 if get_action_strength("power") > 0.0 else  1.0 if poewer_up else 0.9
			var bounce_f_x = (1.5-log(bounce_count)/log(10)) if get_action_strength("power") > 0.0 else  (1.1-log(bounce_count)/log(10)) if poewer_up else 0.85
			_velocity = prev_velocity.bounce(get_slide_collision(0).normal)*Vector2(bounce_f_x,bounce_f_y)
			is_jumping = true
			is_hopping = false
			if poewer_up:
				bounce_count += 1
		elif is_on_floor() and abs(_velocity.y) > 100:
			_velocity = prev_velocity.bounce(get_slide_collision(0).normal)*0.5
			is_jumping = true
			is_hopping = false
		else:
			_velocity = get_velocity(_velocity, direction, speed, x_acc, y_acc, delta)
		
		_velocity.x = int(round(_velocity.x))
		_velocity.y = int(round(_velocity.y))
		prev_velocity = _velocity
	#	_velocity = move_and_slide(_velocity, Vector2.UP)
		_velocity = move_and_slide_with_snap(_velocity, Vector2.ZERO, Vector2.UP, true)
	
func get_x_acc() -> float: 
	var acc_fact = abs(get_action_strength("move_right") - get_action_strength("move_left"));
	if acc_fact == 0:
		return -x_acc_rate * 6
	return x_acc_rate * acc_fact
	
func get_y_acc() -> float:
	if get_action_strength("jump") == 0:
		return gravity	
	return gravity - y_acc_rate
	
func get_direction() -> Vector2:
	return Vector2(
		get_action_strength("move_right") - get_action_strength("move_left"),
		-1.0 if is_action_just_pressed("jump") and is_on_floor() else 0
	)

#func get_velocity(
#		linear_velocity: Vector2,
#		direction: Vector2,
#		delta: float,
#		speed: Vector2,
#		is_jump_interrupted: bool
#	) -> Vector2:
#	var new_velocity: = linear_velocity
#	new_velocity.x = speed.x * direction.x
#	new_velocity.y += gravity * delta
#	if direction.y < 0.0:
#		new_velocity.y = speed.y * direction.y
#	if is_jump_interrupted:
#		new_velocity.y = 0
#	return new_velocity

func get_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	x_acc: float,
	y_acc: float,
	delta: float
) -> Vector2:
	var out: = linear_velocity
	if is_on_floor() or is_hopping:
		var absVelX = abs(out.x)
		if out.x == 0.0 and direction.x != 0:
			absVelX = speed.x
			
		if (x_acc > 0.0 and absVelX < max_x) or (x_acc < 0.0 and absVelX > 0.0):
			var velX = absVelX + x_acc * delta
			if velX > max_x:
				velX = max_x
			if velX < 0.0:
				velX = 0.0
				
			if direction.x < 0.0 or (direction.x == 0.0 and out.x <0.0):
				out.x = velX * (-1.0)
			else:
				out.x = velX
			
	var absVelY = abs(out.y)
	if out.y == 0.0 and direction.x < 0:
		absVelY = speed.x
		
	if ((is_on_floor() or is_hopping) and get_action_strength("jump") > 0.0) and !is_jumping:
		out.y = -speed.y
		is_jumping = true
		is_hopping = false
	elif abs(_velocity.y) > 100.1 and !is_jumping:
		is_jumping = true
		is_hopping = false
	elif is_on_floor():
		poewer_up = false
		is_jumping = false
		is_hopping = false
	
	out.y += gravity * delta
	if is_jumping:
		out.x += out.y * delta *0.1 if out.x >= 0.0 else  out.y * delta * -0.1
			
	
	if is_on_floor() and abs(out.x) > 10:
		is_hopping = true
		out.y -= 70.0
	return out




func _on_Bouncy_on_death():
	$AnimationPlayer.play("EGGPLOTION")
	yield($AnimationPlayer,"animation_finished")
	emit_signal("game_over")
