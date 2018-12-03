extends Area2D


export var speed = 450
export var damage = 10



func _process(delta):
	position.y += speed * delta
	
	if position.y > 2000:
		queue_free()


func _on_body_entered(body):
	if body.name == "Player":
		body.add_damage(damage)
		queue_free()
