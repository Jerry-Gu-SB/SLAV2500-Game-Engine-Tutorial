extends CanvasLayer

@onready var score_label = $ScoreLabel
@onready var robot = $"../RoboCharacter"

func _process(_delta: float) -> void:
	score_label.text = "Score: " + str(robot.score)
