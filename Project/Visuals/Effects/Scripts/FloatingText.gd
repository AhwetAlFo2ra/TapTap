extends Node2D

@onready var label = $Label

var amount = 0
var velocity: Vector2

func _ready():
	label.set_text(str(amount))
	
	randomize()
	var side_movement = randi() % 121 - 60
	velocity = Vector2(side_movement, 200)

	var tween = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector2(1.5,1.5), 0.1)
	tween.chain().tween_property(self, "scale", Vector2(0.1,0.1), 0.3).set_delay(0.3)
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	self.queue_free()

func _process(delta):
	position -= velocity * delta
