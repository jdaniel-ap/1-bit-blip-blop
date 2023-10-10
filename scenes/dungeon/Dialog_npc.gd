extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var animated_sprite2d = $AnimatedSprite2D 

func _process(_delta):
	if animated_sprite2d == null:
		return
	
	var player = owner.get_node('Player') as Node2D
	
	if player == null:
		return
		
	var has_to_flip_h = true
	
	if player.global_position.x > global_position.x:
		has_to_flip_h = false
		
	animated_sprite2d.flip_h = has_to_flip_h

