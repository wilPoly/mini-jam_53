extends CanvasLayer

onready var health := $GUI/Screen/Top/Player/MarginContainer/Health/Number
onready var inventory_junk := $GUI/Screen/Top/Player/Inventory/Junk/Number
onready var inventory_leather := $GUI/Screen/Top/Player/Inventory/Leather/Number
onready var inventory_metal := $GUI/Screen/Top/Player/Inventory/Metal/Number
onready var inventory_wood := $GUI/Screen/Top/Player/Inventory/Wood/Number
onready var message := $Center/Message
onready var event_console := $GUI/Screen/Bottom/World/EventConsole
onready var storm_timer := $GUI/Screen/Bottom/World/StormTimer

onready var player_health = $"../Player".health
onready var player_inventory = $"../Player".inventory
onready var level_objective = get_parent().objective
onready var storm_time_left = $"../EventTimer"


func _ready() -> void:
	health.text = String(player_health)
	get_inventory_item(player_inventory)
	set_objective(level_objective)


func _process(delta: float) -> void:
	storm_timer.text = "Time before next storm: " + update_time(storm_time_left.get_time_left())


func on_health_changed(new_health) -> void:
	health.text = String(new_health)


func get_inventory_item(inventory) -> void:
	var items = inventory.keys()
	var quantities = inventory.values()
	
	for item in items:
		match item:
			"Junk":
				inventory_junk.text = String(quantities[0])
			"Leather":
				inventory_leather.text = String(quantities[1])
			"Metal":
				inventory_metal.text = String(quantities[2])
			"Wood":
				inventory_metal.text = String(quantities[3])


func on_item_picked_up(inventory) -> void:
	get_inventory_item(inventory)


func set_objective(text) -> void:
	message.text = level_objective
	$AnimationPlayer.play("objective_fade_out")


func update_time(time_left:float) -> String:
	var minutes : int
	var seconds : int
	var time_string : String
	seconds = int(time_left) % 60
	minutes = int(time_left) / 60
	time_string = str(minutes) + ":" + str(seconds)
	return time_string
