extends Node2D

signal removeConcrete

var concretePieces = []
var width = 8
var height = 10
var concrete = preload("res://Scenes/concrete.tscn")
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

func _on_Grid_makeConcrete(boardPosition):
	if concretePieces.size() == 0:
		concretePieces = Make2DArray()
	var current = concrete.instance()
	add_child(current)
	current.position = Vector2(boardPosition.x*64 + 64 , -boardPosition.y *64 +800)
	concretePieces[boardPosition.x][boardPosition.y] = current
	pass # Replace with function body.
	
func _on_Grid_damageConcrete(boardPosition):
	if boardPosition.x < 10 && boardPosition.y < 10:
		if concretePieces[boardPosition.x][boardPosition.y] != null:
			concretePieces[boardPosition.x][boardPosition.y].TakeDamage(1)
			if concretePieces[boardPosition.x][boardPosition.y].health <= 0:
				concretePieces[boardPosition.x][boardPosition.y].queue_free()
				concretePieces[boardPosition.x][boardPosition.y] = null
				emit_signal("removeConcrete", boardPosition)
	pass # Replace with function body.

