extends Node2D

@onready var animation = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("coin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		self.queue_free()
		body.score += 1
		print(body.score)
