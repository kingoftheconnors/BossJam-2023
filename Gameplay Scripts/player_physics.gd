extends KinematicBody2D

class_name PlayerPhysics

export(float) var GRV = 10.5

onready var left_wall = $LeftWallSensor
onready var right_wall = $RightWallSensor

onready var character = $Character

onready var stateAnimator = $MovementState

var velocity : Vector2

var jump_timer = 0
const JUMP_TIME = .4
var coyote_time = 0
const COYOTE_TIME = .1

var power : int = 10

func _process(delta):
	jump_timer -= (delta if jump_timer > 0 else 0)
	coyote_time -= (delta if coyote_time > 0 else 0)
	if Input.is_action_just_pressed("jump"):
		jump_timer = JUMP_TIME
	elif Input.is_action_just_released("jump"):
		jump_timer = 0

func physics_step():
	if is_on_floor():
		coyote_time = COYOTE_TIME

func try_start_state(state_name : String):
	stateAnimator.try_start_state(state_name)
