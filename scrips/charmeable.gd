class_name Interactable 
extends Area2D

@export var energy_consume : int = 2

var charmed : bool


func interact():
	$Sprite2D.modulate = Color8(255,0,0,255)
	charmed = true

func sacar():
	$Sprite2D.modulate = Color8(255,255,255,255)
	charmed = false
