extends Node


func get_nearest_enemy_global_pos():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var player = get_tree().get_nodes_in_group("player")[0]
	
	if enemies.size() == 0:
		return
	
	var closest_enemy = enemies[0]
	var cur_dist = player.global_position.distance_to(closest_enemy.global_position)
	
	for enemy in enemies:
		var new_dist = player.global_position.distance_to(enemy.global_position)
		
		if new_dist < cur_dist:
			cur_dist = new_dist
			closest_enemy = enemy
	
	return closest_enemy.global_position
