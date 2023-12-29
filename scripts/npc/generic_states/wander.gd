extends State

var wander_time : float

func randomize_wander():
	randomize()
	target.move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randi_range(1,3)

func enter(args):
	anim.play("walk")
	randomize_wander()

func state_process(delta : float) -> void:
	if wander_time > 0:
		wander_time -= delta
	else:
		transitioned.emit(self, "idle", {})

func state_physics_process(_delta : float) -> void:
	target.velocity = target.move_direction * target.speed
	target.move_and_slide()
