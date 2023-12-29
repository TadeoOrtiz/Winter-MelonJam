extends State

@onready var sprite_2d = %Sprite2D

var wait_time := 2.0

func enter(args):
	anim.play("charm_walk")
	anim.speed_scale = 0.5

func state_physics_process(delta : float) -> void:
	
	if wait_time < 0:
		transitioned.emit(self, "CharmIdle", {})
		
	else:
		wait_time -= delta
		target.velocity = (target.charm_target.global_position - target.global_position).normalized() * 15
		target.move_and_slide()
