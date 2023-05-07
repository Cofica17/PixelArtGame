extends Node

func get_rng():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng

func get_random_int_number(from:int, to:int):
	return get_rng().randi_range(from, to)

func get_random_float_number(from:float, to:float):
	return get_rng().randf_range(from, to)

func get_item_scene(item_name):
	return load("res://items/pickup_items/"+item_name+"/"+item_name+".tscn")
