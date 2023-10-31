extends Resource

class_name data_level

@export var display_name: String
@export var enemy_weak: Array[data_enemy] = []
@export var enemy_boss: data_enemy
@export var enemy_weak_minHP: float
@export var enemy_weak_maxHP: float
@export var enemy_boss_minHP: float
@export var enemy_boss_maxHP: float
 

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_display_name = "Level Name", p_enemy_boss = null, p_enemy_weak_minHP=0, p_enemy_weak_maxHP = 10, p_enemy_boss_minHP = 0, p_enemy_boss_maxHP = 10):
	display_name = p_display_name
	enemy_boss = p_enemy_boss
	enemy_weak_minHP = p_enemy_weak_minHP
	enemy_weak_maxHP = p_enemy_weak_maxHP
	enemy_boss_minHP = p_enemy_boss_minHP
	enemy_boss_maxHP = p_enemy_boss_maxHP
