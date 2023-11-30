extends Node2D

@export var start_pos: Vector2 = Vector2(0,0)
@export var end_pos: Vector2 = Vector2(0,0)
@export var time_in_air: float = 1.0

@export var movementCurve: Curve
@export var y_adjustment: Curve
@export var y_max_height: float = 10.0

signal tween_complete

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_method(update_location_tween, 0.0, 1, time_in_air)
	tween.connect("finished", on_tween_finished)

func update_location_tween(t: float):
	var new_position = start_pos.lerp(end_pos, movementCurve.sample(t))
	new_position.y -= y_max_height * y_adjustment.sample(t)
	set_position(new_position)
	pass

func on_tween_finished():
	tween_complete.emit()
	queue_free()
	pass
