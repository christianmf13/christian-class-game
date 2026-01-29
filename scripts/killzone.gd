extends Area2D
@onready var kill_timer: Timer = $KillTimer


func _on_body_entered(body: Node2D) -> void:
	body.get_node("CollisionShape2D").queue_free()
	
	kill_timer.start()
	Engine.time_scale = 0.5


func _on_kill_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
