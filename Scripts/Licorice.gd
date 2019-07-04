extends Node2D

export (int) var health


func _ready():
	pass 

func TakeDamage(damage):
	health -= damage