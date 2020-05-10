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

var item_last_quantity : int


func _ready() -> void:
	health.text = String(player_health)
	set_inventory(player_inventory)
	set_objective(level_objective)


func _process(delta: float) -> void:
	storm_timer.text = "Time before next storm: " + update_time(storm_time_left.get_time_left())


func on_health_changed(new_health) -> void:
	health.text = String(new_health)


func on_item_picked_up(item, quantity) -> void:
	update_inventory(item, quantity)


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


func set_inventory(inventory) -> void:
#	TODO => refactor
#	for key in dict:
#    print(key, " -> ", dict[key])
	var items = inventory.keys()
	var quantities = inventory.values()

	for item in items:
		match item:
			"Junk":
				inventory_junk.set_text(String(quantities[0]))
				continue
			"Leather":
				inventory_leather.set_text(String(quantities[1]))
				continue
			"Metal":
				inventory_metal.set_text(String(quantities[2]))
				continue
			"Wood":
				inventory_metal.set_text(String(quantities[3]))
				continue


func update_inventory(item, quantity) -> void:
	match item:
		"Junk":
			inventory_junk.set_text(str(quantity))
			event_console.set_text("Picked up " + str(quantity) + " Junk")
		"Leather":
			inventory_leather.set_text(str(quantity))
			event_console.set_text("Picked up " + str(quantity) + " Leather")
		"Metal":
			inventory_metal.set_text(str(quantity))
			event_console.set_text("Picked up " + str(quantity) + " Metal")
		"Wood":
			inventory_metal.set_text(str(quantity))
			event_console.set_text("Picked up " + str(quantity) + " Wood")
