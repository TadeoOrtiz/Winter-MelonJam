extends State

@onready var dash_component = %DashComponent

func enter(args := {}):
	anim.play("walk")

func state_physics_process(delta):
	target.velocity = target.move_direction * target.speed
	target.move_and_slide()
	if target.move_direction == Vector2.ZERO:
		transitioned.emit(self, "idle", {})

func state_input(event : InputEvent):
	if event.is_action_pressed("dash"):
		if dash_component.can_dash:
			transitioned.emit(self, "Dash", {})
