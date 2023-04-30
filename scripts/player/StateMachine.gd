extends Node
class_name StateMachine

signal transitioned(state)

@onready var _state: State

var initial_state := Idle.new()

func _init():
	# make sure the node is always in the "state_machine" group
	add_to_group("state_machine")

func _ready():
	# wait until the owner is ready
	await get_parent().ready

	# transition to the initial state
	transition_to(initial_state)

func _input(event):
	# delegate the _input handling to the current state
	if not _state:
		return
	
	_state.input(event)

func _unhandled_input(event):
	if not _state:
		return
	
	# delegate the _unhandled_input handling to the current state
	_state.unhandled_input(event)

func _process(delta):
	if not _state:
		return
	
	# delegate the _process handling to the current state
	_state.process(delta)

func _physics_process(delta):
	if not _state:
		return
	
	# delegate the _physics_process handling to the current state
	_state.physics_process(delta)

func transition_to(new_state:State):
	# if there's no node at the specified path, don't do anything
	if not new_state:
		return
	
	# if we're already in the same state or if the node is not a State node, don't do anything
	if (_state and new_state.get_script() == _state.get_script()) || !(new_state is State):
		return

	# exit the current state, set the current to the new state and enter it, and emit transitioned signal
	if _state:
		_state.exit()
		remove_child(_state)
		_state.queue_free()
	
	_state = new_state
	add_child(_state)
	_state.enter()
	emit_signal("transitioned", _state)
