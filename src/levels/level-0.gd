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
	players = [bouncy, hardy, floaty]
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
	print("Player", currentPlayer)
	players[currentPlayer].select(true)


func _on_GameStartTimer_timeout():
	start_timer.stop()
	playerSelection()


func _on_Portal_playes_at_base(players: Array):
	print(players)
	if players.size() == 3:
		$Portal.teleport()
	
