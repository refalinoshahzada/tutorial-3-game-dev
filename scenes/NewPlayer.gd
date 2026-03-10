extends CharacterBody2D

@export var SPEED := 200
@export var JUMP_SPEED := -400
@export var GRAVITY := 1200

@onready var animplayer = $AnimatedSprite2D

func _physics_process(delta):

	velocity.y += GRAVITY * delta

	var direction = Input.get_axis("ui_left","ui_right")

	var animation = "idle"

	if direction != 0:
		animation = "walk_right"
		velocity.x = direction * SPEED

		if direction > 0:
			animplayer.flip_h = false
		else:
			animplayer.flip_h = true
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_SPEED

	if animplayer.animation != animation:
		animplayer.play(animation)

	move_and_slide()
