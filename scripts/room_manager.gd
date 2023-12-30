class_name RoomManager
extends Node2D

const PLAYER_NODE := preload("res://nodes/player.tscn")

@export var corner_left_up : Marker2D
@export var corner_right_down : Marker2D

@export var player_spawns : Array[Marker2D]

var camera : CameraController
var player : Entity

@onready var label = %Label
@onready var color_rect = %ColorRect

func _ready():
	
	player = PLAYER_NODE.instantiate()
	
	player.global_position = player_spawns.pick_random().global_position
	player.wasted.connect(wasted)
	
	add_child(player)
	
	camera = CameraController.new()
	
	var left : int = int(corner_left_up.global_position.x)
	var top : int = int(corner_left_up.global_position.y)
	var right : int = int(corner_right_down.global_position.x)
	var bottom : int = int(corner_right_down.global_position.y)
	
	camera.set_limits(left, top, right, bottom)
	camera.zoom = Vector2(3,3)
	camera.target = player
	
	add_child(camera)
	
	for child in get_children():
		if child is Entity:
			child.room = self

func wasted():
	var tween = create_tween()
	
	tween.tween_property(camera, "zoom", Vector2(10,10), 5)
	tween.parallel().tween_property(label, "modulate", Color8(255, 255, 255, 255), 2.5)
	tween.parallel().tween_property(color_rect, "color", Color8(0, 0, 0, 128), 2.5)
	#camera.scale

func _unhandled_key_input(event : InputEvent):
	if event.is_action_pressed("ui_end"):
		get_tree().reload_current_scene()

