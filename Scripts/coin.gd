extends Node2D

@onready var animation = $AnimatedSprite2D
@onready var coin_sound = $AudioStreamPlayer2D
var is_collected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("coin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_collected:
		is_collected = true
		coin_sound.play()
		self.queue_free()
		body.score += 1
		print(body.score)
