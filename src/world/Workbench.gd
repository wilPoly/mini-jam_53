extends Area2D

export var shed = { "Junk": 0, "Leather": 0, "Metal": 1, "Wood": 5 }


func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.has_method("on_workbench_entered"):
		body.on_workbench_entered(self)


func _on_body_exited(body: PhysicsBody2D) -> void:
	if body.has_method("on_workbench_exited"):
		body.on_workbench_exited(self)


func craft(object) -> void:
	pass


func on_craft(player_inventory, craft_target) -> void:
	craft_target = shed
	var player_qt = player_inventory.values()
	var craft_qt = craft_target.values()
	
	for qt in craft_qt:
		for p_qt in player_qt:
			if p_qt >= qt:
				craft(craft_target)
			else:
				print("Not enough material")
				
		
		
	
