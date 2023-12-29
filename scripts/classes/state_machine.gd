class_name StateMachine
extends Node

@export var inital_state : State
@export var animation_player : AnimationPlayer
@export var target : Entity

var states : Dictionary

var current_state : State

func _ready():
	for child in get_children():
		child.target = target
		child.anim = animation_player
		child.transitioned.connect(change_state)
		
		states[child.name.to_upper()] = child
	
	current_state = inital_state
	current_state.enter({})

func _process(delta):
	if current_state:
		current_state.state_process(delta)

func _physics_process(delta):
	if current_state:
		current_state.state_physics_process(delta)

func _input(event):
	if current_state:
		current_state.state_input(event)

func change_state(state : State, new_state_name : String, args : Dictionary):
	if state != current_state:
		return
	
	var new_state : State = states[new_state_name.to_upper()]
	if !new_state:
		return
	
	current_state.exit()
	current_state = new_state
	current_state.enter(args)
