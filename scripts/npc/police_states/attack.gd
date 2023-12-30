extends State


func enter(args):
	anim.play("attack")
	args.target.death()
