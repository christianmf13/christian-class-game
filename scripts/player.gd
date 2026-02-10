extends CharacterBody2D

@onready var interact_hint: Label = %InteractHint
@onready var player_in_area : = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const SPEED : float = 150.0
const JUMP_VELOCITY : float = -300.0
var last_direction : float
var BOUNCE_VELOCITY : float = -300.0

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
	

#Bounce
func bounce() -> void:
	velocity.y = BOUNCE_VELOCITY

#animations
func handle_animation() -> void:
	if is_on_floor() and last_direction == 0:
		animated_sprite_2d.play("idle")
	elif is_on_floor() and last_direction != 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("jump")
		
#door ending/change scene
func _on_exit_door_body_entered(body: Node2D) -> void:
	player_in_area = true
	print("area entered")
	interact_hint.text = "PressW/Up Arrow to interact"

func _on_exit_door_body_exited(body: Node2D) -> void:
	player_in_area = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact") and player_in_area == true:
		get_tree().change_scene_to_file("res://scenes/credits.tscn")
