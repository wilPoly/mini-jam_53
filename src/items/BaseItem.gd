extends Area2D

signal picked_up

export (String, "Junk", "Wood", "Metal", "Leather") var item_type = "Junk"
export (int) var quantity = 1


func _ready() -> void:
	set_sprite()


func _on_body_entered(body: Node) -> void:
	if body.has_method("on_pickup_entered"):
		body.on_pickup_entered(self)
#		print(item_type)


func _on_body_exited(body: Node) -> void:
	if body.has_method("on_pickup_exited"):
		body.on_pickup_exited(self)

func on_pickup() -> void:
	queue_free()


func set_sprite() -> void:
	match item_type:
		"Junk":
			$Sprite.region_rect = Rect2(238, 425, 16, 16)
		"Wood":
			$Sprite.region_rect = Rect2(255, 459, 16, 16)
		"Metal":
			$Sprite.region_rect = Rect2(255, 425, 16, 16)
		"Leather":
			$Sprite.region_rect = Rect2(255, 510, 16, 16)
