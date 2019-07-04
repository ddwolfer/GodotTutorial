extends CanvasLayer

func SlideIn():
	$AnimationPlayer.play("slide_in")

func SlideOut():
	$AnimationPlayer.play_backwards("slide_in")
