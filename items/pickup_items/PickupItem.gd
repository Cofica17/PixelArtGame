extends Item

@onready var player = get_tree().get_nodes_in_group("player")[0]
var go_to_player = false
var travel_speed = 5.0
var pickup_distance = 20
var amount:int = 1

func _physics_process(delta):
	if go_to_player:
		global_position = global_position.move_toward(player.global_position, delta*travel_speed)
		travel_speed += travel_speed/10.0
		if global_position.distance_to(player.global_position) < pickup_distance:
			pickup()

func _on_area_2d_body_entered(body):
	if body is Player:
		go_to_player = true

func pickup():
	queue_free()
	player.add_item(item_id, amount)
