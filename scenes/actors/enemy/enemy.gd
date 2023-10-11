extends CharacterBody2D


@export var speed = 1000.0
const JUMP_VELOCITY = -400.0
const direction := 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if animated_sprite == null:
		return 
	
	var player = owner.get_node_or_null('Player') as Node2D;
	
	if player == null:
		animated_sprite.play('idle')
		return

	var has_to_flip_sprite = true
	var normalized_vector = (player.global_position - global_position).normalized()
	velocity.x = normalized_vector.x * speed * delta
	
	if player.global_position.x > global_position.x:
		has_to_flip_sprite = false

	animated_sprite.flip_h = has_to_flip_sprite
	move_and_slide()


func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("move")
