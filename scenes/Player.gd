extends CharacterBody2D

@export var walk_speed = 200
@export var gravity = 300.0
@export var jump_speed = -300
@export var max_jumps = 2
@export var dash_speed = 600
@export var dash_duration = 0.2
@export var dash_cooldown = 1.0	
@onready var anim = $AnimatedSprite2D

var is_dashing = false
var is_crouching = false
var can_dash = true
var dash_time_left = 0.0
var jump_count = 0

func _physics_process(delta):
	# for dash timer
	if is_dashing:
		dash_time_left -= delta
		if dash_time_left <= 0:
			is_dashing = false
		move_and_slide()
		return

	# gravitu
	velocity.y += gravity * delta

	# reset jump counter
	if is_on_floor():
		jump_count = 0

	# for jumping
	if Input.is_action_just_pressed("ui_up") and jump_count < max_jumps:
		velocity.y = jump_speed
		jump_count += 1

	# crouching
	is_crouching = Input.is_action_pressed("ui_down") and is_on_floor()
	
	# left and right
	if is_crouching:
		velocity.x = 0
	else:
		if Input.is_action_pressed("ui_left"):
			velocity.x = -walk_speed
			anim.flip_h = true
		elif Input.is_action_pressed("ui_right"):
			velocity.x = walk_speed
			anim.flip_h = false
		else:
			velocity.x = 0

	# dashing
	if Input.is_action_just_pressed("dash") and can_dash:
		start_dash()

	move_and_slide()
	update_animation()

func update_animation():
	if is_dashing:
		anim.play("dash")
	elif is_crouching:
		anim.play("crouch")
	elif !is_on_floor():
		anim.play("jump")
	elif velocity.x != 0:
		anim.play("run")
	else:
		anim.play("idle")
		
func start_dash():
	is_dashing = true
	can_dash = false
	dash_time_left = dash_duration

	# setting the dash direction
	var dash_direction = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		dash_direction = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		dash_direction = Vector2.RIGHT
	else:
		dash_direction = Vector2.RIGHT if !anim.flip_h else Vector2.LEFT

	velocity = dash_direction * dash_speed

	# Start cooldown timer
	await get_tree().create_timer(dash_cooldown).timeout
	can_dash = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
