extends Area2D

export (String, "Junk", "Leather", "Metal", "Wood") var item_type = "Junk" #TODO => enum to streamline it
export (int) var quantity = 1
export (float) var damage = -10.0

var damage_proba : float


func _ready() -> void:
	_set_sprite()


func _on_body_entered(body: Node) -> void:
	if body.has_method("on_pickup_entered"):
		body.on_pickup_entered(self)
#		print(item_type)


func _on_body_exited(body: Node) -> void:
	if body.has_method("on_pickup_exited"):
		body.on_pickup_exited(self)


func _set_sprite() -> void:
	match item_type:
		"Junk":
			$Sprite.region_rect = Rect2(238, 425, 16, 16)
			damage_proba = 0.20
		"Leather":
			$Sprite.region_rect = Rect2(255, 510, 16, 16)
			damage_proba = 0.01
		"Metal":
			$Sprite.region_rect = Rect2(255, 425, 16, 16)
			damage_proba = 0.10
		"Wood":
			$Sprite.region_rect = Rect2(255, 459, 16, 16)
			damage_proba = 0.05


# TODO => probability that an item hurts player on pickup
func _set_damage() -> void:
	pass

func on_pickup() -> void:
	queue_free()
