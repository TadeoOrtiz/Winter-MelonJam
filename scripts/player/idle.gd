extends State

@onready var dash_component = %DashComponent as DashComponent

func enter(args := {}):
	anim.play("idle")

func state_process(delta):
	if target.move_direction:
		transitioned.emit(self, "Walk", {})
	

func state_input(event : InputEvent):
	if event.is_action_pressed("dash"):
		if dash_component.can_dash and target.energy >= dash_component.energy_consume:
			transitioned.emit(self, "Dash", {})
