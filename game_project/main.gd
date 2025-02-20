extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	

	if $Player.position.x < $leader_viking.position.x:
		$leader_viking/AnimatedSprite2D.flip_h = true
	else:
		$leader_viking/AnimatedSprite2D.flip_h = false
