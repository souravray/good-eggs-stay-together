extends Node2D
onready var textbox : RichTextLabel
var is_showing = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tips = [
	"Use Arrow Keys to move Right and Left. \nUse 'C' Key to Jump",
	"Use Space Bar to select a different egg",
	"Floaty can make a Double Jump. Hold 'Z' Key while in the air",
	"Bouncy can Wall Bounce. Use 'Z' Key get an extra bounce",
	"Floaty can change direction during a Double Jump",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	textbox = get_node("CanvasLayer/ColorRect2/RichTextLabel")
	

func show_tips(index):
	if !is_showing:
		is_showing = not is_showing
		textbox.add_text(tips[index])
		print(tips[index])
		$AnimationPlayer.play("Show")
		yield($AnimationPlayer, "animation_finished")
		$AnimationPlayer.play("Hide")
		textbox.clear()
		is_showing = not is_showing
	

