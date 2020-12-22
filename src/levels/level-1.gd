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
	players = [floaty, hardy, bouncy]
	start_timer.start()
	$Tips.show_tips(2)
	


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
#	$Knife.rotate_back()


func _on_Portal_playes_at_base(players: Array):
#	print(players)
	if players.size() == 3:
		$Portal.teleport()
	


func _on_Switch_swich_state(state):
	if state :
		$Knife.rotate_down()
	else:
		$Knife.rotate_up()


func _on_Knife_dead(player):
	currentPlayer = -1
	var body = get_node(player)
	body.die()


func _on_Floaty_game_over():
	$Portal.reload()


func _on_Hardy_game_over():
	print("HERE 1")
	$Portal.reload()


func _on_Bouncy_game_over():
	$Portal.reload()
