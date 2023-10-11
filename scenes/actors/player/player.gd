extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

var is_jumping = false
var is_taking_damage = false
var player_life = 2
var knockback_vector := Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if !is_taking_damage:
			animated_sprite.play("jump")
	else:
		if !is_taking_damage:
			if player_life > 0:
				animated_sprite.play("idle")
				
	
	if player_life != 0:
		# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("move_left", "move_right")

		if direction:
			velocity.x = direction * SPEED
			animated_sprite.scale.x = direction
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if knockback_vector != Vector2.ZERO:
			velocity = knockback_vector

		move_and_slide()


func _on_hurtbox_body_entered(body: Node2D):
	if body.is_in_group('enemies'):
		if $RayCast2DRight.is_colliding():	
			take_damage(Vector2(-300,-200))
		elif $RayCast2DLeft.is_colliding():
			take_damage(Vector2(300,-200))


func _on_animated_sprite_2d_animation_finished():
	if player_life == 0:
		$Camera2D.reparent(get_parent().get_node('Enemy'))
		queue_free()
	is_taking_damage = false



func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	var damage = max(player_life -1 ,0)
	player_life = damage
	is_taking_damage = true
	
	if player_life >= 1:
		animated_sprite.play('hit')
	else:
		animated_sprite.play("death")
		
	
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		var knockback_tween := create_tween()
		knockback_tween.tween_property(self, 'knockback_vector', Vector2.ZERO, duration)
		
	
