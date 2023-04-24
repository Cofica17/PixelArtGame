extends Spell
class_name Fireball

@export var travel_speed = 250
@export var damage = 50
@export var cooldown = 1.0

var dir

func cast():
	super.cast()
	var enemy_pos = Game.get_nearest_enemy_global_pos()
	if not enemy_pos is Vector2:return
	global_position = player.global_position
	dir = player.global_position.direction_to(enemy_pos)

func _physics_process(delta):
	if dir:
		global_position += dir * travel_speed * delta

func _on_area_2d_body_entered(body):
	if body is Player:
		return
	
	if body is Enemy:
		body.hit(damage)
	
	destroy()
