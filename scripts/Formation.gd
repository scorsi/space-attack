extends Node2D


export var speed = 200

var target_position
var left_bound
var right_bound
var direction
var is_in_position = false
var enemies_count


signal was_defeated



func _ready():
	target_position = rand_range(200, get_viewport_rect().size.y / 2)
	left_bound = position.x - 100
	right_bound = position.x + 100
	direction = 1 if rand_range(0, 100) > 50 else -1
	enemies_count = get_children().size()


func _process(delta):
	_movement(delta)
	position.x += speed * delta * direction
	if position.x > right_bound:
		direction = -1
	elif position.x < left_bound:
		direction = 1


func _movement(delta):
	if is_in_position:
		return
	
	position.y += speed * delta
	
	if position.y >= target_position:
		position.y = target_position
		is_in_position = true


func _on_Enemy_was_defeated():
	enemies_count -= 1
	
	if enemies_count == 0:
		emit_signal("was_defeated")
		queue_free()
