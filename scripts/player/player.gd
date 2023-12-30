class_name Player
extends Entity

signal wasted


@onready var dash_component = %DashComponent as DashComponent
@onready var energy_cooldown = $EnergyCooldown as Timer



# Variables de atributos
var level := 1
var level_attributes := {
	# Level : Max Energy
	1 : 5,
	2 : 12,
	3 : 20
}
var points : int:
	set(value):
		points = value
		match points:
			3:
				level = 2
				energy_regeneration = 0.4
			7:
				level = 3
				energy_regeneration = 0.8

# Variables de energia
var energy : float = 10:
	set(value):
		energy = value
		energy = clampf(energy, 0, level_attributes[level])
var energy_regeneration : float = 0.1

# Variables de interacción
var charmeable_nodes : Array[Interactable]
var target : Interactable

func _ready():
	energy_cooldown.timeout.connect(func():
		energy += energy_regeneration
	)
	speed = 80

func _process(delta):
	if not dash_component.is_dashing():
		move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
		if move_direction != Vector2.ZERO:
			dash_component.dash_direction = move_direction
	
	
	if velocity.x < 0:
		$Sprite2D.scale.x = -1
	elif velocity.x > 0:
		$Sprite2D.scale.x = 1
	
	if Input.is_action_just_pressed("charm"):
		if target != null:
			if not target.charmed and not target.death:
				if energy >= target.energy_consume: 
					target.charmed = true
					target.charm_target = self
					energy -= target.energy_consume
					
					if charmeable_nodes.size() > 0:
						target = charmeable_nodes[0]
			else:
				if target.ready_to_consume:
					points += 1
					target.death = true
					charmeable_nodes.erase(target)
			
			$StateMachine.current_state.transitioned.emit($StateMachine.current_state, "Charm", {})
	
	_update_label()

func _update_label():
	%Label.text = ""
	
	var info := {
		"Energy" : energy,
		"Poinst": points,
		"Level": level
	}
	
	for i in info:
		%Label.text += i + ": " + str(info[i]) + "\n"

func _on_intereact_area_body_entered(body):
	if body.is_in_group("Charmeable"):
		charmeable_nodes.append(body)
		target = body

func _on_intereact_area_body_exited(body):
	if body.is_in_group("Charmeable"):
		charmeable_nodes.erase(body)
		if charmeable_nodes.size() > 0:
			target = charmeable_nodes[0]
		else:
			target = null

func death():
	$StateMachine.current_state.transitioned.emit($StateMachine.current_state, "Wasted", {})
