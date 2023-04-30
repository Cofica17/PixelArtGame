extends Spell
class_name LightningStrike

@export var damage = 50
@export var strikes_count = 3.0

var StrikeScene = preload("res://spells/lightning_strike/Strike.tscn")

func cast():
	casted = true
	var enemies:Array = Game.get_nearest_enemy(strikes_count)
	if enemies.is_empty():return
	for enemy in enemies:
		var strike = StrikeScene.instantiate()
		add_child(strike)
		strike.follow_pos = enemy.global_position
		enemy.hit(damage)

func _process(delta):
	if casted:
		if get_child_count() == 0:
			queue_free()
