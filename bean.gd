extends RigidBody2D

var avg_speed: float

func _ready() -> void:
	body_entered.connect(_body_entered)

func _process(delta: float) -> void:
	avg_speed = lerp(avg_speed, linear_velocity.length(), delta)

func _body_entered(_body):
	$AudioOnCollide.volume_linear = (2.0 / (1 + exp(-avg_speed * 0.01))) - 1.0
	print($AudioOnCollide.volume_linear)
	$AudioOnCollide.pitch_scale = randf_range(0.9, 1.0)
	$AudioOnCollide.play()
