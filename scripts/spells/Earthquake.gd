extends Spell
class_name Earthquake

@export var damage = 10
@export var cooldown = 1.0
@export var duration = 2.0

@onready var timer = $Timer

var dir

func cast():
	super.cast()
	var player_dir = player.controls.get_look_vector()
	global_position = pl ayer.global_position + 40*player_dir
	hit_enemies()
	look_at(get_global_mouse_position())

func hit_enemies():
	for body in area.get_overlapping_bodies():
		if body is Enemy:
			body.hit(damage)

func _on_animated_sprite_2d_frame_changed():
	if animated_sprite.frame == 7:
		animated_sprite.pause()
		timer.start(duration)

func _on_timer_timeout():
	animated_sprite.play()

func _on_area_2d_body_entered(body):
	if body is Enemy:
		body.hit(damage)
