extends Node
class_name Items

enum items {
	WOOD
}

static func get_item_name(value):
	return items.keys()[value].to_lower()
