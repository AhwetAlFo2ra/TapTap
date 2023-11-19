extends Node2D

@onready var panel = $SelectedMapPanel
@onready var mapNameLabel = $SelectedMapPanel/Label_SelectedMap

# Called when the node enters the scene tree for the first time.
func _ready():
	panel.visible = false

func _on_btn_naqb_pressed():
	print("NAQB")
	panel.visible = true
	mapNameLabel.set_text("NQAB")

func _on_btn_ramla_pressed():
	print("RAMLA")
	panel.visible = true
	mapNameLabel.set_text("RAMLA")

func _on_btn_gaza_pressed():
	print("GAZA")
	panel.visible = true
	mapNameLabel.set_text("GAZA")

func _on_game_click_pressed():
	panel.visible = false


func _on_btn_start_pressed():
	get_tree().change_scene_to_file("res://GameTest/MainScreen.tscn")
