extends KinematicBody2D

# HUD
signal health_changed
signal item_picked_up

# Workbench
signal crafting

# Items
signal picked_up

export (int) var speed := 150
export (float) var health = 100.0
export (float) var health_max := 100.0
export (float) var thirst_damage := -10.0

var velocity : Vector2
var can_pickup := false
var can_craft := false
var item_local : Node
var workbench_local : Node
var craft_default : Node
var inventory = {"Junk": 0, "Leather": 0, "Metal": 0, "Wood": 0}


func _ready() -> void:
	$DeathTimer.start()
	connect("health_changed", $"../HUD", "on_health_changed")
	connect("item_picked_up", $"../HUD", "on_item_picked_up")


func _process(delta: float) -> void:
	_pickup(item_local)
	_craft()


func _physics_process(delta: float) -> void:
	velocity = _movement() * speed * delta
	move_and_collide(velocity)
	
	
func _movement() -> Vector2:
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if abs(velocity.x) == 1 and abs(velocity.y) == 1:
		velocity = velocity.normalized()
		return velocity
	return velocity
	
	
func _pickup(item: Node) -> void:
	if can_pickup:
		if Input.is_action_just_pressed("ui_accept"):
			_update_inventory(item)
			emit_signal("picked_up")
			_update_health(item.damage)


func _update_inventory(item: Node) -> void:
	inventory[item.item_type] += item.quantity
	emit_signal("item_picked_up", item.item_type, item.quantity)


func _update_health(health_change: float) -> void:
	var new_health :float = health + health_change
	health = min(new_health, health_max)
	emit_signal("health_changed", health)


func _craft() -> void:
	if can_craft:
		if Input.is_action_just_pressed("ui_accept"):
			emit_signal("crafting", inventory, craft_default)

func _on_DeathTimer_timeout() -> void:
	_update_health(thirst_damage)


func on_health_change(health_change: float):
	_update_health(health_change)
	

func on_pickup_entered(item) -> void:
	item_local = item
	can_pickup = true
	connect("picked_up", item, "on_pickup")
	
	
func on_pickup_exited(item) -> void:
	can_pickup = false
	disconnect("picked_up", item, "on_pickup")


func on_oasis_entered(oasis) -> void:
	$DeathTimer.stop()


func on_oasis_exited(oasis) -> void:
	$DeathTimer.start()


func on_workbench_entered(workbench) -> void:
	workbench_local = workbench
	can_craft = true
	print("Craft enabled")
	connect("crafting", workbench, "on_craft")
	

func on_workbench_exited(workbench) -> void:
	can_craft = false
	disconnect("crafting", workbench, "on_craft")
