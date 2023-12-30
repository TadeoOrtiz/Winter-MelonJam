extends State

var chase_target : Node2D

@onready var nav : NavigationAgent2D = %NavigationAgent2D


func enter(args):
	anim.play("walk")
	chase_target = args.target

func state_process(_delta : float) -> void:
	nav.target_position = chase_target.global_position
	target.move_direction = (nav.get_next_path_position() - target.global_position).normalized()

func state_physics_process(_delta : float) -> void:
	target.velocity = target.move_direction * target.speed
	target.move_and_slide()

