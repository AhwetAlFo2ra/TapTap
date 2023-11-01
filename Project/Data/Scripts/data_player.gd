extends Resource

class_name data_player

@export var display_name: String
@export var player_visual: PackedScene
@export var player_damage: float
@export var unlocked: bool
 

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_display_name = "Player Name", p_player_visual = null, p_player_damage = 10, p_unlocked = false):
	display_name = p_display_name
	player_visual = p_player_visual
	player_damage = p_player_damage
	unlocked = p_unlocked
