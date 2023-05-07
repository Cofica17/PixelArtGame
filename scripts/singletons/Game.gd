extends Node

func spawn_item(drop_table_item:DropTableItem, spawn_pos):
	var ItemScene = Utilities.get_item_scene(drop_table_item.item_name)
	var item = ItemScene.instantiate()
	add_child(item)
	item.amount = Utilities.get_random_int_number(drop_table_item.min_amount, drop_table_item.max_amount)
	item.global_position = spawn_pos
	print(item.amount)

func get_nearest_enemy(num_of_enemies:int=1):
	var enemies = get_tree().get_nodes_in_group("enemy")
	var player = get_tree().get_nodes_in_group("player")[0]
	
	if enemies.size() == 0:
		return []
	
	var closest_enemies = []
	
	for enemy in enemies:
		var new_dist = player.global_position.distance_to(enemy.global_position)
		
		if closest_enemies.size() < num_of_enemies:
			closest_enemies.append(enemy)
		if new_dist < player.global_position.distance_to(closest_enemies.back().global_position):
			closest_enemies.pop_back()
			closest_enemies.append(enemy)
		
		closest_enemies.sort_custom(sort_enemies_by_player_distance)
	
	return closest_enemies

func sort_enemies_by_player_distance(a, b):
	var player = get_tree().get_nodes_in_group("player")[0]
	return player.global_position.distance_to(a.global_position) < player.global_position.distance_to(b.global_position)
