#in the Piece Scene Piece node

extends Node2D

export (String) var pieceColor;
var moveTween
var matched = false

func _ready():
	moveTween = get_node("MoveTween")	


func move(target):
	moveTween.interpolate_property(self, "position", position, target, .3, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	moveTween.start()

#配對成功後把棋子變淡
func dim():
	var sprite = get_node("Sprite")
	sprite.modulate = Color(1,1,1,.5)
	pass

