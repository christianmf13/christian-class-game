extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("What a pretty fruit..... Nothing happens...")
	queue_free()
