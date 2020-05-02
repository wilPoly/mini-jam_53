extends Area2D

signal life_given

export (float) var health_buff = 10.0

var actor : Node2D

func _on_body_entered(body: Node) -> void:
	if body.has_method("on_oasis_entered"):
		body.on_oasis_entered(self)
		connect("life_given", body, "on_health_change")
		$Timer.start()


func _on_body_exited(body: Node) -> void:
	if body.has_method("on_oasis_exited"):
		body.on_oasis_exited(self)
		disconnect("life_given", body, "on_health_change")
		$Timer.stop()
	

func _on_Timer_timeout() -> void:
	emit_signal("life_given", health_buff)
