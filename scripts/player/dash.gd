extends State

@onready var dash_component = %DashComponent as DashComponent

func enter(args):
	if target.energy < dash_component.energy_consume:
		transitioned.emit(self, "Idle", {})
	else:
		dash_component.start_dash()
		target.energy -= dash_component.energy_consume
	

func state_physics_process(_delta : float) -> void:
	target.velocity = dash_component.dash_direction * dash_component.dash_force
	target.move_and_slide()
	if not dash_component.is_dashing():
		transitioned.emit(self, "Idle", {})
