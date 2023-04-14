extends Node
class_name Controls


var _move_vec: Vector2 = Vector2.ZERO
var _is_attacking: bool = false

func _ready():
	await get_parent().ready

func _process(delta):
	# determine the movement direction based checked the input strengths of the four movement directions
	var dx := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var dy := Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")

	# and set the movement direction vector to the normalized vector so the player can't unintentionally
	# move faster when moving diagonally
	_move_vec = Vector2(dx, -dy).normalized()

	# in both desktop and touch screen devices the jump flag can be determined via the jump action
	# same goes for other actions
	_is_attacking = InputBuffer.is_action_press_buffered("attack")

func _input(event):
	pass

func get_movement_vector():
	return _move_vec

func is_attacking():
	return _is_attacking


