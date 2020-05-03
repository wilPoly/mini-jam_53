extends CanvasLayer

onready var health := $GUI/Screen/Top/Player/MarginContainer/Health/Number
onready var inventory_junk := $GUI/Screen/Top/Player/Inventory/Junk/Number
onready var inventory_leather := $GUI/Screen/Top/Player/Inventory/Leather/Number
onready var inventory_metal := $GUI/Screen/Top/Player/Inventory/Metal/Number
onready var inventory_wood := $GUI/Screen/Top/Player/Inventory/Wood/Number
onready var objective := $GUI/Screen/Top/Player/Objective/Text
onready var event_console := $GUI/Screen/Bottom/World/EventConsole
onready var storm_timer := $GUI/Screen/Bottom/World/StormTimer

onready var player_health = $"../Player".health
onready var player_inventory = $"../Player".inventory

func _ready() -> void:
	health.text = String(player_health)
	


func on_health_changed(new_health) -> void:
	health.text = String(new_health)


func get_inventory_item() -> void:
	pass
	# TODO - creates the inventory_item vars


func on_item_picked_up(item_type, quantity) -> void:
	match item_type:
		"Junk":
			inventory_junk.text = String(quantity)
		"Leather":
			inventory_leather.text = String(quantity)
		"Metal":
			inventory_metal.text = String(quantity)
		"Wood":
			inventory_metal.text = String(quantity)
