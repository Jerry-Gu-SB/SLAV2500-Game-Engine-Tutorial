extends CharacterBody2D

@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")
@onready var sprite = $AnimatedSprite2D  

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var gravity = 900

func _ready():
	anim_tree.active = true  

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Movement input
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		if direction < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
			
		if is_on_floor():
			anim_state.travel("robot_walk")  
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim_state.travel("robot_idle")  

	# Jumping
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim_state.travel("robot_jump")  

	# Falling transition (Only happens when NOT on the floor)
	if not is_on_floor() and velocity.y > 0:
		anim_state.travel("robot_fall")  

	# Prevent instant switching by waiting for the next physics frame
	if is_on_floor() and anim_state.get_current_node() == "robot_fall":
		anim_state.travel("robot_idle")  

	move_and_slide()
