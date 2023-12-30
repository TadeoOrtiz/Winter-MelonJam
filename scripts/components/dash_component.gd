class_name DashComponent
extends Node

signal dash_finished

@export var dash_force : float
@export var dash_duration : float
@export var dash_cooldown : float
@export var energy_consume : float

var dash_timer : Timer
var cooldown_timer : Timer

var can_dash := true
var dash_direction := Vector2(1, 0)

func _ready():
	dash_timer = Timer.new()
	dash_timer.wait_time = dash_duration
	dash_timer.one_shot = true
	dash_timer.timeout.connect(func():
		dash_finished.emit()
		)
	
	cooldown_timer = Timer.new()
	cooldown_timer.wait_time = dash_cooldown
	cooldown_timer.one_shot = true
	cooldown_timer.timeout.connect(
		func():
			can_dash = true
	)
	
	add_child(dash_timer)
	add_child(cooldown_timer)

func start_dash():
	if cooldown_timer.time_left <= 0:
		can_dash = false
		dash_timer.start()
		cooldown_timer.start()

func is_dashing() -> bool:
	return dash_timer.time_left > 0
