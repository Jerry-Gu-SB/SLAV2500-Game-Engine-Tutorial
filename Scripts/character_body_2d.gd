extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var landing = false
var score = 0

func _ready():
	animation_tree.active = true

func _process(_delta):
	update_animation_parameters()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		AudioManager.play("res://brackeys_platformer_assets/sounds/jump.wav")
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func update_animation_parameters():
	landing = is_on_floor()
	if is_on_floor():
		animation_tree["parameters/conditions/is_idle"] = velocity.x == 0
		animation_tree["parameters/conditions/is_walking"] = velocity.x != 0
		animation_tree["parameters/conditions/is_jumping"] = false
		animation_tree["parameters/conditions/is_falling"] = false
	else:
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_walking"] = false

		if velocity.y >= 0:
			animation_tree["parameters/conditions/is_falling"] = true
			animation_tree["parameters/conditions/is_jumping"] = false
		else:
			animation_tree["parameters/conditions/is_falling"] = false
			animation_tree["parameters/conditions/is_jumping"] = true
