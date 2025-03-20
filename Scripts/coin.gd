extends Node2D

@onready var animation = $AnimatedSprite2D
var is_collected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("coin")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_collected:
		is_collected = true
		AudioManager.play("res://brackeys_platformer_assets/sounds/coin.wav")
		self.queue_free()
		body.score += 1
		print(body.score)
