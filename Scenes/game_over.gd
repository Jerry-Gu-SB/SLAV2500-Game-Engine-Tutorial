extends Node2D

@onready var button = $Button
@onready var label = $Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if button.button_pressed:
		get_tree().change_scene_to_file("res://Scenes/world.tscn")
