extends Area2D

@export var speed = 400
var screen_size
var timer_check = false
var impatient_on = false
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$CollisionShape2D.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		impatient_on = false
		timer_check = false
	else:
		$AnimatedSprite2D.play()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "run_side"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "run_down"
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "run_up"
	
	if velocity.length() == 0:
		if timer_check == false:
			$idle_timer.start()
			timer_check = true
		
		if impatient_on == false:
			$AnimatedSprite2D.animation = "idle"
			$AnimatedSprite2D.flip_v = false
		

func _on_idle_timer_timeout():
	$AnimatedSprite2D.animation = "impatient_idle"
	impatient_on = true
