extends Area2D

# Shed
export var shed = { "Junk": 0, "Leather": 0, "Metal": 1, "Wood": 5 }
export (PackedScene) onready var shed_world

func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.has_method("on_workbench_entered"):
		body.on_workbench_entered(self)


func _on_body_exited(body: PhysicsBody2D) -> void:
	if body.has_method("on_workbench_exited"):
		body.on_workbench_exited(self)


func on_craft(player_inventory, craft_target) -> void:
	craft_target = shed
	var c_t = craft_target
	var p_i = player_inventory
	var bool_array = []
	
	for i in range(5):
		bool_array[i] = false
	
	var i = 0
	
	while i < 5:
		for craft_qt in craft_target:
			for player_qt in player_inventory:
				if craft_qt == player_qt:
					if craft_target[craft_qt] <= player_inventory[player_qt]:
						bool_array[i] = true
					i += 1
				else:
					continue
	
	var can_craft = false
	
	if bool_array.count(true) == 4:
		can_craft = true # => can load craft, need object_ref

# TODO
#func load_craft(craft_o)
