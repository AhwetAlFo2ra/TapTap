extends Resource

class_name data_enemy

@export var display_name: String
@export var enemy_visual: PackedScene
#@export var enemy_visual: Resource
 

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_display_name = "enemy_name", p_enemy_visual = null):
	display_name = p_display_name
	enemy_visual = p_enemy_visual
