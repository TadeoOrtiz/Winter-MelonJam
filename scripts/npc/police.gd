extends Entity


func _ready():
	speed = 70

func _process(delta):
	
	
	
	if velocity.x < 0:
		$Sprite2D.scale.x = -1
	elif velocity.x > 0:
		$Sprite2D.scale.x = 1

func _on_vision_entered(area):
	pass
