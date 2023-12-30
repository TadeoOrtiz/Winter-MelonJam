extends State

func enter(args):
	anim.play("idle")
	target.wasted.emit()
