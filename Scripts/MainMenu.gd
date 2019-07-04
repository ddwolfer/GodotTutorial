extends "res://Scripts/BaseMenu.gd"

signal playPressed
signal settingPressed


func _on_Button1_pressed():
	emit_signal("playPressed")
	pass # Replace with function body.


func _on_Button2_pressed():
	emit_signal("settingPressed")
	pass # Replace with function body.
