extends Node
class_name GameManager

@onready var points_label: Label = %PointsLabel


var score : int = 0

func add_points(points : int) -> void:
	score += points
	print(score)
	points_label.text = "Coins:" + str(score)
