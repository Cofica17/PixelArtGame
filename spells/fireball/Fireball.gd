extends Spell
class_name Fireball

@export var travel_speed = 250
@export var damage = 50
@export var cooldown = 1.0

var dir

func cast():
	super.cast()
	var enemy = Game.get_nearest_enemy()
	if enemy.is_empty():return
	global_position = player.global_position
	dir = player.global_position.direction_to(enemy[0].global_position)

func _physics_process(delta):
	if dir:
		global_position += dir * travel_speed * delta

func _on_area_2d_body_entered(body):
	if body is Player:
		return
	
	if body is Enemy:
		body.hit(damage)
	
	destroy()
