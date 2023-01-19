extends Node

export(Array, NodePath) var state_names = []
var states = {}

onready var host = get_parent()
onready var current_state : String = str(state_names[0])

func _ready():
	for state_name in state_names:
		states[str(state_name)] = get_node(state_name)
	states[current_state].enter(host)

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		states[current_state].attack(host)
	if Input.is_action_just_pressed("special"):
		states[current_state].special(host)
	if Input.is_action_just_released("special"):
		states[current_state].special_released(host)

func _physics_process(delta):
	host.physics_step()
	var state_name = states[current_state].step(host, delta)
	if state_name and state_name in state_names:
		change_state(state_name)
	states[current_state].animation_step(host, delta)

func try_start_state(state_name : String):
	if state_name in state_names:
		change_state(state_name, true)

func change_state(state_name, restart_if_already_started = false):
	if state_name == current_state and !restart_if_already_started:
		return
	
	if states[state_name].can_enter(host):
		states[current_state].exit(host)
		current_state = state_name
		states[current_state].enter(host)
