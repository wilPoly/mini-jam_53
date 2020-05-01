extends Area2D


enum Type { JUNK, WOOD, METAL}
export (Type) var item_type


func _on_body_entered(body: Node) -> void:
	if body.has_method("on_pickup_entered"):
		body.on_pickup_entered(self)


func _on_body_exited(body: Node) -> void:
	if body.has_method("on_pickup_exited"):
		body.on_pickup_exited(self)

func on_pickup() -> void:
	queue_free()
