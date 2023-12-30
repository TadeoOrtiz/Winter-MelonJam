extends Entity

@onready var ray_cast_2d : RayCast2D = %RayCast2D

var reference : Node2D

func _ready():
	speed = 65

func _process(delta):
	if velocity.x < 0:
		$Sprite2D.scale.x = -1
		%Pistol.scale.y = -1
	elif velocity.x > 0:
		$Sprite2D.scale.x = 1
		%Pistol.scale.y = 1
	
	
	if reference != null:
		ray_cast_2d.target_position = reference.global_position - global_position
		if not ray_cast_2d.is_colliding():
			$StateMachine.current_state.transitioned.emit($StateMachine.current_state, "Chase", {"target" : reference})


func _on_vision_area_body_entered(body):
	ray_cast_2d.target_position = body.global_position - global_position
	ray_cast_2d.enabled = true
	ray_cast_2d.force_raycast_update()
	if not ray_cast_2d.is_colliding():
		$StateMachine.current_state.transitioned.emit($StateMachine.current_state, "Chase", {"target" : body})

func _on_vision_area_body_exited(body):
	ray_cast_2d.enabled = false
	reference = null
	$StateMachine.current_state.transitioned.emit($StateMachine.current_state, "Idle", {})


func _on_shot_area_body_entered(body):
	$StateMachine.current_state.transitioned.emit($StateMachine.current_state, "Shot", {"target" : body})

func _on_shot_area_body_exited(body):
	$StateMachine.current_state.transitioned.emit($StateMachine.current_state, "Chase", {"target" : body})


func _on_capture_area_body_entered(body):
	$StateMachine.current_state.transitioned.emit($StateMachine.current_state, "Attack", {"target" : body})
