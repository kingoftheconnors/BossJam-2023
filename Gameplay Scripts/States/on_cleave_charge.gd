extends '../state.gd'

func enter(host: PlayerPhysics):
	host.velocity = Vector2.ZERO

func step(host : PlayerPhysics, delta):
	host.velocity.y += host.GRV

func animation_step(host : PlayerPhysics, animator : CharacterAnimator):
	if animator:
		animator.update(CharacterAnimator.STATE.CLEAVE_CHARGE)
