extends Node2D

@onready var timer = $Timer
@onready var player_parent = $PlayerParent
@onready var enemy_parent = $EnemyParent
@onready var label_enemy_count = $UI/Label

@onready var progressBar = $ProgressBar
@onready var label_enemy_name = $ProgressBar/Label_EnemyName
@onready var label_enemy_hp = $ProgressBar/Label_EnemyHP

var floating_damage_text = preload("res://Visuals/Effects/FloatingText.tscn")

@export var level_data: data_level
var enemy = null
var enemyHealth = 1000
var enemy_dead_counter: int = 0
var max_enemy_in_level: int = 6

@export var allowed_players_data: data_allowed_players
var player = null
var playerDamage = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	_get_player()
	_get_weak_enemy()
	_update_label_count_ui()

func _on_game_gui_input(event):
	if enemyHealth <= 0:
		return
	if event is InputEventScreenTouch and event.is_pressed():
		enemyHealth -= playerDamage
		progressBar.value = enemyHealth
		label_enemy_hp.set_text(str(max(enemyHealth,0)))
		var tween = create_tween().set_parallel(true)
		
		tween.tween_property(enemy.get_child(0), "rotation_degrees", (randi() % 40 + -20), 0.05)
		tween.chain().tween_property(enemy.get_child(0), "rotation_degrees", 0, 0.05)
		
		var text_instance = floating_damage_text.instantiate()
		text_instance.amount = playerDamage
		add_child(text_instance)
		var test = enemy.get_child(0).get_scale()
		text_instance.position = enemy.get_child(0).get_global_position()-Vector2(0,test.y*64)
		if enemyHealth <= 0:
			#enemy.visible = false
			enemy_dead_counter += 1
			_update_label_count_ui()
			#progressBar.visible = false
			timer.start(0.8)
			tween.tween_property(enemy.get_child(0), "modulate", Color.TRANSPARENT, 0.4)


func _on_respawntimer_timeout():
	enemy.queue_free()
	if (enemy_dead_counter + 1) % max_enemy_in_level == 0:
		_get_boss_enemy()
	else:
		_get_weak_enemy()
	enemy.visible = true
	#progressBar.visible = true
	enemy.modulate = Color.WHITE

func _get_random_in_range(min:float, max:float) -> float:
	return randi() % ((max-min) as int) + min
	
func _get_weak_enemy():
	var enemy_data = level_data.enemy_weak[randi() % level_data.enemy_weak.size()]
	label_enemy_name.set_text(enemy_data.display_name)
	enemy = enemy_data.enemy_visual.instantiate()
	enemy_parent.add_child(enemy)
	enemyHealth = _get_random_in_range(level_data.enemy_weak_minHP, level_data.enemy_weak_maxHP)
	enemyHealth = snappedi(enemyHealth, 50)
	label_enemy_hp.set_text(str(enemyHealth))

	progressBar.max_value = enemyHealth
	progressBar.value = enemyHealth

func _get_boss_enemy():
	var enemy_data = level_data.enemy_boss
	label_enemy_name.set_text(enemy_data.display_name)
	enemy = enemy_data.enemy_visual.instantiate()
	enemy_parent.add_child(enemy)
	enemyHealth = _get_random_in_range(level_data.enemy_boss_minHP, level_data.enemy_boss_maxHP)
	enemyHealth = snappedi(enemyHealth, 50)
	label_enemy_hp.set_text(str(enemyHealth))

	progressBar.max_value = enemyHealth
	progressBar.value = enemyHealth

func _update_label_count_ui():
	label_enemy_count.text = "{value} / {max}".format({"value": ((enemy_dead_counter % max_enemy_in_level)+1), "max": max_enemy_in_level})

func _get_player():
	if player != null:
		player.queue_free()
	
	var player_data = allowed_players_data.players[allowed_players_data.current_index]
	player = player_data.player_visual.instantiate()
	playerDamage = player_data.player_damage
	player_parent.add_child(player)


func _on_btn_rock_pressed():
	allowed_players_data.current_index = 0
	_get_player()


func _on_btn_gun_pressed():
	allowed_players_data.current_index = 1
	_get_player()
