extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var start_timer = get_node("GameStartTimer")
onready var bouncy = get_node("Bouncy")
onready var hardy = get_node("Hardy")
onready var floaty = get_node("Floaty")

var currentPlayer = -1
var players

# Called when the node enters the scene tree for the first time.
func _ready():
	players = [bouncy, floaty, hardy]
	start_timer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("select") and currentPlayer >= 0:
		playerSelection()
	return

func playerSelection():
	# deselect the current user
	if currentPlayer >=0 and currentPlayer < players.size():
		players[currentPlayer].select(false)
	# select new player 
	currentPlayer = currentPlayer+1 if currentPlayer+1 < players.size() else 0
	players[currentPlayer].select(true)
	$Control.show_card(players[currentPlayer].get_name())


func _on_GameStartTimer_timeout():
	start_timer.stop()
	playerSelection()
	if self.get_name() == "Level2":
		$Tips.show_tips(3)
	elif self.get_name() == "Level3":
		$Tips.show_tips(4)


func _on_Portal_playes_at_base(players: Array):
#	print(players)
	if players.size() == 3:
		$Portal.teleport()
	


func _on_Switch_swich_state(state):
	if state :
		$Knife.rotate_down()
		$Knife2.rotate_down()
	else:
		$Knife.rotate_up()
		$Knife2.rotate_up()

func _on_Switch2_swich_state(state):
	if state :
		$Knife3.rotate_down()
		$Knife2.rotate_down()
	else:
		$Knife3.rotate_up()

func _on_Knife_dead(player):
	currentPlayer = -1
	var body = get_node(player)
	body.die()


func _on_Floaty_game_over():
	$Portal.reload()


func _on_Hardy_game_over():
	$Portal.reload()


func _on_Bouncy_game_over():
	$Portal.reload()


func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.has_method("get_x_acc") :
		currentPlayer = -1
		var _player = get_node(body.get_name())
		_player.die()



