class_name CameraController extends Camera2D

var target : Node2D

func _ready():
	position_smoothing_enabled = true
	if target != null:
		global_position = target.global_position

func _physics_process(delta):
	if target != null:
		global_position = target.global_position

func set_limits(left : int, top : int, right : int, bottom : int, smooth : bool = true):
	limit_left = left
	limit_top = top
	limit_right = right
	limit_bottom = bottom
	limit_smoothed = smooth
