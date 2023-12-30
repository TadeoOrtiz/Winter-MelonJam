extends State

func enter(args):
	anim.play("charm_idle")
	target.ready_to_consume = true
