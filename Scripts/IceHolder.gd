extends Node2D

var icePieces = []
var width = 8
var height = 10
var ice = preload("res://Scenes/IcePiece.tscn")
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

#在棋子上面放冰塊特效START
func _on_Grid_makeIce(boardPosition):
	if icePieces.size() == 0:
		icePieces = Make2DArray()
	var current = ice.instance()
	add_child(current)
	current.position = Vector2(boardPosition.x*64 + 64 , -boardPosition.y *64 +800)
	icePieces[boardPosition.x][boardPosition.y] = current
	pass # Replace with function body.
#在棋子上面放冰塊特效END


func _on_Grid_damageIce(boardPosition):
	print(boardPosition)
	if icePieces[boardPosition.x][boardPosition.y] != null:
		icePieces[boardPosition.x][boardPosition.y].TakeDamage(1)
		if icePieces[boardPosition.x][boardPosition.y].health <= 0:
			icePieces[boardPosition.x][boardPosition.y].queue_free()
			icePieces[boardPosition.x][boardPosition.y] = null
	
	pass # Replace with function body.
