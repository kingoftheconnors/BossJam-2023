extends '../../Gameplay Scripts/state.gd'

var cleave_charging = false
var cleave_charge : int = 0

export(NodePath) var sword

func attack(host : PlayerPhysics):
	host.power = 10
	host.try_start_state("OnSlash")
func special(host : PlayerPhysics):
	if host.is_on_floor():
		cleave_charging = true
		cleave_charge = 0
		host.try_start_state("OnCleaveCharge")
	else:
		host.power = 20
		host.try_start_state("OnCleaveDown")
func special_released(host : PlayerPhysics):
	if cleave_charging and cleave_charge > 0:
		host.power = cleave_charge
		host.try_start_state("OnGround")
		cleave_charging = false

func step(host: PlayerPhysics, delta: float):
	if cleave_charging:
		cleave_charge += 1
