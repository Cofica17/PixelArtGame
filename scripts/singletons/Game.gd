extends Node


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
