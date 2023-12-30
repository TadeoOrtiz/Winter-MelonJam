extends State

const BULLET_NODE := preload("res://nodes/bullet.tscn")

var chase_target : Node2D
var shoot_time := 2.0

@onready var nav : NavigationAgent2D = %NavigationAgent2D

func enter(args):
	anim.play("walk")
	%Pistol.visible = true
	chase_target = args.target

func state_process(delta : float) -> void:
	nav.target_position = chase_target.global_position
	target.move_direction = (nav.get_next_path_position() - target.global_position).normalized()
	%Pistol.look_at(chase_target.global_position)
	
	
	if shoot_time <= 0:
		shoot()
		shoot_time = 1
	else:
		shoot_time -= delta
	

func state_physics_process(_delta : float) -> void:
	target.velocity = target.move_direction * (target.speed)
	target.move_and_slide()

func shoot():
	%AnimationPlayer2.play("shoot")

func create_bullet():
	var b = BULLET_NODE.instantiate()
	b.direction = (chase_target.global_position - target.global_position).normalized()
	b.global_position = target.global_position + Vector2(0, -6)
	target.add_sibling(b)

func exit():
	%Pistol.visible = false
