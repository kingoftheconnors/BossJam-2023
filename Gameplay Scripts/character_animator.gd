extends AnimationTree
class_name CharacterAnimator

const SPEED_INVERSE : int = 25

enum STATE {
	IDLE,
	MOVE,
	ROLL,
	CLEAVE_CHARGE,
	CLEAVE_CHARGE_RELEASE,
	CLEAVE_DOWN,
	SLASH,
}

func get_animation_state():
	var playback : AnimationNodeStateMachinePlayback = get("parameters/playback")
	return playback.get_current_node()

func update(state : int):
	var playback : AnimationNodeStateMachinePlayback = get("parameters/playback")
	if playback:
		match state:
			STATE.IDLE:
				playback.travel("Idle")
			STATE.MOVE:
				playback.travel("Move")
			STATE.ROLL:
				playback.travel("Roll")
			STATE.SLASH:
				playback.travel("Slash")
			STATE.CLEAVE_CHARGE:
				playback.travel("CleaveCharge")
			STATE.CLEAVE_CHARGE_RELEASE:
				playback.travel("CleaveRelease")
			STATE.CLEAVE_DOWN:
				playback.travel("CleaveDown")
