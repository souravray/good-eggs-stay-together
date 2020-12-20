extends Line2D

export(NodePath) var targetpath
export var trailenlen = 2000

var point
var target

func _ready():
	target = get_node(targetpath)
	
func _process(delta):
	global_position = Vector2.ZERO
	global_rotation = 0
	point = target.global_position
	add_point(point)
	while get_point_count() > trailenlen:
		remove_point(0)
