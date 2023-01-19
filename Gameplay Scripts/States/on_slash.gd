extends '../state.gd'

var time_elapsed = 0

func enter(host: PlayerPhysics):
	time_elapsed = 0
	host.velocity.x *= .9

func step(host : PlayerPhysics, delta):
	time_elapsed += delta
	if time_elapsed >= 0.2:
		return 'OnGround'
	host.velocity.y += host.GRV

func animation_step(host : PlayerPhysics, animator : CharacterAnimator):
	if animator:
		animator.update(CharacterAnimator.STATE.SLASH)
