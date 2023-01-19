# Interface for states
extends Node

func can_enter(host: PlayerPhysics) -> bool:
	return true

func enter(host: PlayerPhysics):
	return

func step(host: PlayerPhysics, delta: float):
	return

func exit(host: PlayerPhysics):
	return

func animation_step(host: PlayerPhysics, animator: CharacterAnimator):
	return

func attack(host):
	return
func special(host):
	return
func special_released(host):
	return
