class_name State
extends Node

signal transitioned(state : State, new_state_name : String, args : Dictionary)

var target : Entity
var anim : AnimationPlayer

func _to_string():
	return "state_name : {name}".format(
		{
			"name" : name,
		}
		)

func enter(_args: Dictionary) -> void:
	pass

func exit() -> void:
	pass

func state_process(_delta : float) -> void:
	pass

func state_physics_process(_delta : float) -> void:
	pass

func state_input(_event : InputEvent) -> void:
	pass
