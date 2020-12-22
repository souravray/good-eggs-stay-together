extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var start_timer = get_node("GameStartTimer")
onready var bouncy = get_node("Bouncy")
onready var hardy = get_node("Hardy")
onready var floaty = get_node("Floaty")
var _shown_selection = false
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
	players[currentPlayer].select(true)
	$Control.show_card(players[currentPlayer].get_name())

func _on_GameStartTimer_timeout():
	start_timer.stop()
	playerSelection()
	$Tips.show_tips(0)


func _on_Portal_playes_at_base(players: Array):
	if players.size() == 3:
		$Portal.teleport()
	elif players.size() > 0 and !_shown_selection:
		_shown_selection = true
		$TipsTimer.start()
	


func _on_TipsTimer_timeout():
	print("Done")
	$TipsTimer.stop()
	$Tips.show_tips(1)
