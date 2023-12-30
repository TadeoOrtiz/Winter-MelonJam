extends State

var idle_time := 2.0

func enter(args : Dictionary) -> void:
	anim.play("idle")
	randomize()
	idle_time = randi_range(1, 3)

func state_process(delta : float) -> void:
	if idle_time > 0:
		idle_time -= delta
	else:
		transitioned.emit(self, "Wander", {})
	
	if target.charmed:
		transitioned.emit(self, "Charm", {})
