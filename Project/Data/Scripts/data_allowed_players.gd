extends Resource

class_name data_allowed_players

@export var players: Array[data_player] = []
@export var current_index: int

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_current_index = 0):
	current_index = p_current_index
