extends '../state.gd'

var is_braking : bool
var brake_sign : int
var FALL_MULTIPLIER : float = 1.1

const ACCELERATION : int = 10
const START_SPEED = 20
const BASE_SPEED : int = 95
const TURNOFF_SPEED : int = 30
const JUMP_STRENGTH = 260.0
const WALLJUMP_SPEED : int = 200

func step(host : PlayerPhysics, delta):
	var horizontal = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	
	if host.is_on_floor() and (horizontal == 0 or abs(host.velocity.x) > BASE_SPEED):
		host.velocity.x *= 0.87
	host.velocity.x = calc_direc(horizontal, host.velocity.x, ACCELERATION, host, BASE_SPEED)
	host.velocity.y += host.GRV
	is_braking = host.velocity.x * horizontal < 0
	
	# Turning around
	if host.velocity.x > 0:
		host.character.scale.x = 1
	elif host.velocity.x < 0:
		host.character.scale.x = -1
	
	# Jump
	if host.jump_timer > 0 and host.coyote_time > 0:
		host.velocity.y = -JUMP_STRENGTH
		host.coyote_time = 0
		host.jump_timer = 0
	else:
		# Walljump
		if (host.right_wall.is_colliding() or host.left_wall.is_colliding()) and host.jump_timer > 0 and !host.is_on_floor():
			var fall_direction = 1 if host.left_wall.is_colliding() else -1
			host.velocity.x = WALLJUMP_SPEED * fall_direction
			host.velocity.y = -WALLJUMP_SPEED
			host.coyote_time = 0
			host.jump_timer = 0

## Calculates and returns the velocity of a single axis based on direction,
## acceleration, and current speed.
func calc_direc(ui_direc, cur_speed, accel, host : PlayerPhysics, max_speed) -> float:
	if ui_direc == 0 and abs(cur_speed) <= TURNOFF_SPEED:  # Hard stop on release
		return 0.0
	elif ui_direc != 0 and abs(cur_speed) < START_SPEED:
		return ui_direc * START_SPEED
	elif abs(cur_speed + ui_direc*accel) < max_speed or cur_speed * ui_direc < 0:
		return cur_speed + ui_direc*accel
	else:
		return cur_speed

func animation_step(host : PlayerPhysics, animator : CharacterAnimator):
	var state = CharacterAnimator.STATE.IDLE
	#if abs(host.velocity.x) != 0:
	#	state = CharacterAnimator.STATE.MOVE
	if animator:
		animator.update(state)
