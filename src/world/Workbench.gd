extends Area2D

func _on_body_entered(body: Node) -> void:
	if body.has_method("on_workbench_entered"):
		body.on_workbench_entered(self)


func _on_body_exited(body: Node) -> void:
	if body.has_method("on_workbench_exited"):
		body.on_workbench_exited(self)
