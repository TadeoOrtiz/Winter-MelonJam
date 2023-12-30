extends State


@onready var nav : NavigationAgent2D = %NavigationAgent2D


var tile_size := 16
var offset := 2 * tile_size

func _ready():
	nav.navigation_finished.connect(func():
		transitioned.emit(self, "Idle", {})
		)

func randomize_wander():
	randomize()
	var x = randf_range(target.room.corner_left_up.global_position.x + offset, target.room.corner_right_down.global_position.y + offset)
	var y = randf_range(target.room.corner_left_up.global_position.y - offset, target.room.corner_right_down.global_position.x - offset)
	nav.target_position = Vector2(x, y)

func enter(args):
	anim.play("walk")
	randomize_wander()

func state_process(d):
	
	if target.charmed:
		transitioned.emit(self, "Charm", {})

func state_physics_process(_delta : float) -> void:
	target.move_direction = (nav.get_next_path_position() - target.global_position).normalized()
	target.velocity = target.move_direction * target.speed
	target.move_and_slide()
