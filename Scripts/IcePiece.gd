extends Node2D

export (int) var health


func _ready():
	pass # Replace with function body.


func TakeDamage(damage):
	health -= damage
