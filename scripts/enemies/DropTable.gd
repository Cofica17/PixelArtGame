extends Node
class_name DropTable

var items:Array[DropTableItem] = []

var drop_table = {}

func _init(enemy_name):
	var file = "res://scripts/enemies/enemies.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	drop_table = JSON.parse_string(json_as_text)
	for item in drop_table[enemy_name]["drop_table"]:
		items.append(DropTableItem.new(item))
