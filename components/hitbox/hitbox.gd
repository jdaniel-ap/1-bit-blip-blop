extends Area2D



func _on_body_entered(body: Node2D):
	if body.name == 'Player':
		body.velocity.y = body.JUMP_VELOCITY
		var animated_sprite = owner.animated_sprite as AnimatedSprite2D
		animated_sprite.play('hit')
		

