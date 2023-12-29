extends State

func enter(args):
	anim.play("charm_idle")
	print(anim.current_animation)
	#anim.speed_scale = 0.6
	target.ready_to_consume = true
