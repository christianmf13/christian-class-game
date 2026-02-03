extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const SPEED : float = 150.0
const JUMP_VELOCITY : float = -300.0
var last_direction : float

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	last_direction = direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#Flip sprite based on input direction
	if direction > 0:
		animated_sprite_2d.flip_h = false
	if direction < 0:
		animated_sprite_2d.flip_h = true

	move_and_slide()
	handle_animation()
	
func handle_animation() -> void:
	if is_on_floor() and last_direction == 0:
		animated_sprite_2d.play("idle")
	elif is_on_floor() and last_direction != 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
