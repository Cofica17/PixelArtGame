extends Node
class_name DropTableItem

var item_name:String
var min_amount:int
var max_amount:int
var drop_chance:float

func _init(data):
	var _raw_data = data
	if(data is Dictionary):
		for key in data.keys():
			var property = get(key)
			if(property && property.has_method("_init")):
				if(data[key] is Dictionary || data[key] is Array):
					property._init(data[key])
				elif(data[key]):
					set(key, data[key])
			else:
				set(key, data[key])
	elif(data is Array):
		for item in data:
			_set_array_item(item)

func _set_array_item(item):
	pass
