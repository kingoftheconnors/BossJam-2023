extends '../state.gd'

var delay_fall_timer = 0

func enter(host: PlayerPhysics):
	delay_fall_timer = 0.1
	host.velocity.y = 0

func step(host : PlayerPhysics, delta):
	if host.is_on_floor():
		return 'OnGround'
	host.velocity.x *= 0.95
	if delay_fall_timer > 0:
		delay_fall_timer -= delta
	else:
		host.velocity.y += host.GRV*2

func animation_step(host : PlayerPhysics, animator : CharacterAnimator):
	if animator:
		animator.update(CharacterAnimator.STATE.CLEAVE_DOWN)
