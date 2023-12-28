class_name Player
extends CharacterBody2D

@export var speed : float = 150

var energy : int = 10:
	set(value):
		energy = value
		$Label.text = str(energy)

var charmeable_nodes : Array[Interactable]
var target : Interactable

func _ready():
	$Label.text = str(energy)

func _process(delta):
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = direction * speed
	
	move_and_slide()

func _unhandled_key_input(event : InputEvent) -> void:
	
	# Encantar al objetivo mas cercano
	if event.is_action_pressed("ui_accept"):
		if charmeable_nodes.size() > 0:
			
			for node : Interactable in charmeable_nodes:
				if node.charmed:
					continue
				target = node
				break
			
			if target.energy_consume <= energy and not target.charmed:
				
				energy -= target.energy_consume
				
				target.interact()

func _on_intereact_area_area_entered(area : Area2D):
	if area.is_in_group("Charmeable"):
		charmeable_nodes.append(area)


func _on_intereact_area_area_exited(area):
	if area.is_in_group("Charmeable"):
		charmeable_nodes.erase(area)
		area.sacar()
