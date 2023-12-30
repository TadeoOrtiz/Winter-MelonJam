extends Entity
class_name Interactable 

var energy_consume : int = 2
var ready_to_consume : bool
var death : bool:
	set(value):
		death = value
		$StateMachine.current_state.transitioned.emit($StateMachine.current_state, "Death", {})

func _ready():
	speed = 25

func _process(delta):
	
	%Label.text = str($StateMachine.current_state)
	
	if velocity.x < 0:
		$Sprite2D.scale.x = -1
	elif velocity.x > 0:
		$Sprite2D.scale.x = 1
