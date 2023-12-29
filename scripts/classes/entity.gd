class_name Entity
extends CharacterBody2D

# Variables de movimiento
var move_direction : Vector2
var speed := 150.0

var charmed : bool
var charm_pos : Vector2
var charm_target : Entity






# Variables de referencia
#@onready var energy_regeneration_timer = $EnergyRegenerationTimer as Timer
#
#func _ready():
	#
	#energy_regeneration_timer.timeout.connect(func():
		#energy += energy_regeneration
		#energy_regeneration_timer.start()
		#)
	#
	#_update_label()

func _unhandled_key_input(event : InputEvent) -> void:
	pass
	## Encantar al objetivo mas cercano
	#if event.is_action_pressed("ui_accept"):
		#if charmeable_nodes.size() > 0:
			#
			#for node : Interactable in charmeable_nodes:
				#if node.charmed:
					#continue
				#target = node
				#break
			#
			#if target.energy_consume <= energy and not target.charmed:
				#energy -= target.energy_consume
				#points += 1
				#target.interact()

