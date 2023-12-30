extends State

var wait_time : float = 1.2

func enter(args):
	anim.play("attack")
	wait_time = 1.2

func state_process(delta : float) -> void:
	wait_time -= delta
	
	if wait_time <= 0:
		transitioned.emit(self, "Idle", {})

func exit():
	anim.speed_scale = -1
	anim.play("attack")
	anim.speed_scale = 1
