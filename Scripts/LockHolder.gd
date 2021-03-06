extends Node2D

signal removeLock

var lockPieces = []
var width = 8
var height = 10
var lock = preload("res://Scenes/Licorice.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#做棋盤START
func Make2DArray():
	var array = []
	for i in width:
		array.append([]) #變成二維
		for j in height:
			array[i].append(null)
	return array
#做棋盤END

func _on_Grid_makeLock(boardPosition):
	if lockPieces.size() == 0:
		lockPieces = Make2DArray()
	var current = lock.instance()
	add_child(current)
	current.position = Vector2(boardPosition.x*64 + 64 , -boardPosition.y *64 +800)
	lockPieces[boardPosition.x][boardPosition.y] = current
	pass # Replace with function body.
	
func _on_Grid_damageLock(boardPosition):
	if lockPieces[boardPosition.x][boardPosition.y] != null:
		lockPieces[boardPosition.x][boardPosition.y].TakeDamage(1)
		if lockPieces[boardPosition.x][boardPosition.y].health <= 0:
			lockPieces[boardPosition.x][boardPosition.y].queue_free()
			lockPieces[boardPosition.x][boardPosition.y] = null
			emit_signal("removeLock", boardPosition)
	pass # Replace with function body.
