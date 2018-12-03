extends KinematicBody2D


const SPEED = 500

export(PackedScene) var projectile
export var health = 50

onready var timer = $Timer
onready var death_timer = $DeathTimer
onready var audio = $Audio
var min_position
var max_position
var can_shoot = true
var dead = false



func _ready():
	var screen_size = get_viewport_rect().size.x
	var half_size_sprite = $Sprite.texture.get_width() * scale.x / 2
	min_position = half_size_sprite
	max_position = screen_size - half_size_sprite


func _process(delta):
	if Input.is_action_pressed("left"):
		position.x -= SPEED * delta
	elif Input.is_action_pressed("right"):
		position.x += SPEED * delta
	
	position.x = clamp(position.x, min_position, max_position)
	
	if can_shoot and Input.is_action_pressed("shoot"):
		var new_projectile = projectile.instance()
		get_parent().add_child(new_projectile)
		new_projectile.position = position
		can_shoot = false
		timer.start()
		audio.play()


func add_damage(damage):
	if dead:
		return
	
	health -= damage
	if health <= 0:
		dead = true
		death_timer.start()
		set_process(false)
		$Sprite.queue_free()


func _on_Timer_timeout():
	can_shoot = true


func _on_DeathTimer_timeout():
	get_tree().reload_current_scene()
