extends Node


func spawn_projectile(projectile_scene:PackedScene, pos, dmg, dir):
	var projectile:Projectile = projectile_scene.instantiate()
	add_child(projectile)
	projectile.global_position = pos
	projectile.damage = dmg
	projectile.direction = dir
