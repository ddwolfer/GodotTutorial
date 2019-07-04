extends Control


func _ready():
	$Main.SlideIn()
	pass 


func _on_Main_settingPressed():
	$Main.SlideOut()
	$Settings.SlideIn()
	pass # Replace with function body.


func _on_Settings_backButton():
	$Settings.SlideOut()
	$Main.SlideIn()
	pass # Replace with function body.


func _on_Main_playPressed():
	get_tree().change_scene("res://Scenes/gameWindow.tscn")
	pass # Replace with function body.
