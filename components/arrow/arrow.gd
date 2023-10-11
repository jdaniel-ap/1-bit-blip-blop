extends Area2D


const SPEED := 100
var gravit = ProjectSettings.get_setting("physics/2d/default_gravity")

var velocity = Vector2.ZERO
var direction := 1

func set_direction(dir):
	direction = dir
	if direction == 1:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += SPEED * delta * direction
	await get_tree().create_timer(3.0).timeout
	queue_free()  
