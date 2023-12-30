extends Area2D

var direction : Vector2

func _ready():
	look_at(global_position + direction)

func _process(delta):
	global_position += direction * 300 * delta


func _on_timer_timeout():
	queue_free()


func _on_area_entered(area):
	area.get_parent().speed = 30
	await get_tree().create_timer(1).timeout
	area.get_parent().speed = 80
	self.queue_free()
