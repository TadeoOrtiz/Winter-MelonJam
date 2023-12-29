class_name RoomManager
extends TileMap

const PLAYER_NODE := preload("res://nodes/player.tscn")

@export var corner_left_up : Marker2D
@export var corner_right_down : Marker2D

@export var player_spawns : Array[Marker2D]

var camera : CameraController
var player : Entity


func _ready():
	
	player = PLAYER_NODE.instantiate()
	
	player.global_position = player_spawns.pick_random().global_position
	
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

func _unhandled_key_input(event : InputEvent):
	if event.is_action_pressed("ui_end"):
		get_tree().reload_current_scene()

