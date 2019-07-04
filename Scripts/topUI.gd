extends TextureRect

onready var scoreLabel = $MarginContainer/HBoxContainer/ScoreLabel
var currentScore = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_Grid_updateScore(currentScore)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Grid_updateScore(PlusScore):
	currentScore += PlusScore
	scoreLabel.text = String(currentScore)
	pass # Replace with function body.
