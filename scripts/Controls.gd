extends Node
class_name Controls

var _move_vec: Vector2 = Vector2.ZERO
var _look_vec: Vector2 = Vector2.ZERO
var _last_dir_move_vec: Vector2 = Vector2.ZERO
var _is_attacking: bool = false
var _mouse_pos:Vector2 = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	# determine the movement direction based checked the input strengths of the four movement directions
	var dx := Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var dy := Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
	
	# and set the movement direction vector to the normalized vector so the player can't unintentionally
	# move faster when moving diagonally
	_move_vec = Vector2(dx, -dy).normalized()
	if _move_vec.length() > 0:
		_last_dir_move_vec = _move_vec
	
	_look_vec = (_mouse_pos - get_parent().global_transform.origin).normalized()
	
	# in both desktop and touch screen devices the jump flag can be determined via the jump action
	# same goes for other actions
	_is_attacking = InputBuffer.is_action_press_buffered("attack")

func _input(event):
	if event is InputEventMouseMotion:
		_mouse_pos = event.position

func get_movement_vector():
	return _move_vec

func get_look_vector():
	return _look_vec

func get_last_directional_movement_vector():
	return _last_dir_move_vec

func is_attacking():
	return _is_attacking


