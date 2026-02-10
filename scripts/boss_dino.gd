extends Area2D

var SPEED : float = 85.0
var dir : int = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var head_stomp: CollisionShape2D = $HeadStomp
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var killzone: Area2D = $Killzone
@onready var timer: Timer = $Timer



#movement
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		dir = -1
		animated_sprite_2d.flip_h = true
	if ray_cast_left.is_colliding():
		dir = 1
		animated_sprite_2d.flip_h = false
	
	position.x += SPEED * dir * delta

#head stomp
func _on_body_entered(body: Node2D) -> void:
	killzone.monitoring = false
	animated_sprite_2d.play("HeadStomp")
	SPEED = 0
	await animated_sprite_2d.animation_finished
	queue_free()
