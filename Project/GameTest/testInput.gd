extends Node2D

var playerDamage = 100
@onready var progressBar = $ProgressBar
@onready var timer = $Timer
@onready var enemy_parent = $EnemyParent
@onready var label_enemy_count = $UI/Label

@export var leve_data: data_level
var enemy = null
var enemyHealth = 1000
var enemy_dead_counter: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	_get_weak_enemy()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_gui_input(event):
	pass # Replace with function body.
func _on_game_gui_input(event):
	if enemyHealth < 0:
		return
	if event is InputEventScreenTouch and event.is_pressed():
		enemyHealth -= playerDamage
		progressBar.value = enemyHealth
		var tween = create_tween().set_parallel(true)
		enemy.get_child
		tween.tween_property(enemy.get_child(), "rotation_degrees", (randi() % 40 + -20), 0.05)
		tween.chain().tween_property(enemy.get_child(), "rotation_degrees", 0, 0.05)
		if enemyHealth <= 0:
			#enemy.visible = false
			enemy_dead_counter += 1
			label_enemy_count.text = "{value} / 8".format({"value": ((enemy_dead_counter % 8)+1)})
			progressBar.visible = false
			timer.start(0.8)
			tween.tween_property(enemy.get_child(), "modulate", Color.TRANSPARENT, 0.4)


func _on_respawntimer_timeout():
	enemy.queue_free()
	if (enemy_dead_counter + 1) % 8 == 0:
		_get_boss_enemy()
	else:
		_get_weak_enemy()
	enemy.visible = true
	progressBar.visible = true
	enemy.modulate = Color.WHITE

func _get_random_in_range(min:float, max:float) -> float:
	return randi() % ((max-min) as int) + min
	
func _get_weak_enemy():
	var enemy_data = leve_data.enemy_weak[randi() % leve_data.enemy_weak.size()]
	enemy = enemy_data.enemy_visual.instantiate()
	enemy_parent.add_child(enemy)
	enemyHealth = _get_random_in_range(leve_data.enemy_weak_minHP, leve_data.enemy_weak_maxHP)
	
	progressBar.max_value = enemyHealth
	progressBar.value = enemyHealth

func _get_boss_enemy():
	var enemy_data = leve_data.enemy_boss
	enemy = enemy_data.enemy_visual.instantiate()
	enemy_parent.add_child(enemy)
	enemyHealth = _get_random_in_range(leve_data.enemy_boss_minHP, leve_data.enemy_boss_maxHP)
	
	progressBar.max_value = enemyHealth
	progressBar.value = enemyHealth

