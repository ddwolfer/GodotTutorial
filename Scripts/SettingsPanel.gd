extends "res://Scripts/BaseMenu.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

signal soundChange
signal backButton

func _on_Button1_pressed():
	emit_signal("soundChange")
	pass # Replace with function body.


func _on_Button2_pressed():
	emit_signal("backButton")
	pass # Replace with function body.
