extends Area2D

signal picked_up

#enum Type { JUNK, WOOD, METAL}
#export (Type) var type
export (int) var quantity = 1
export (String, "Junk", "Wood", "Metal") var item_type = "Junk"


func _on_body_entered(body: Node) -> void:
	if body.has_method("on_pickup_entered"):
		body.on_pickup_entered(self)
#		print(item_type)


func _on_body_exited(body: Node) -> void:
	if body.has_method("on_pickup_exited"):
		body.on_pickup_exited(self)

func on_pickup() -> void:
	queue_free()
