extends State

var idle_time := 2.0

func enter(args : Dictionary) -> void:
	anim.play("idle")
	idle_time = 2

func state_process(delta : float) -> void:
	if idle_time > 0:
		idle_time -= delta
	else:
		transitioned.emit(self, "Wander", {})
