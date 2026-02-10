extends Area2D
@onready var fruit_label: Label = %FruitLabel
@onready var ui_text: Panel = %UIText


func _on_body_entered(body: Node2D) -> void:
	print("What a pretty fruit..... Nothing happens...")
	ui_text.show()
	
	queue_free()
