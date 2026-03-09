extends RigidBody2D
class_name Bean

var avg_speed: float

var _audio_on_collide: AudioStreamPlayer

func _ready() -> void:
	
	body_entered.connect(_body_entered)
	
	_audio_on_collide = get_parent().get_node("AudioOnCollide")
	
	var r := randf()
	var g := randf()
	
	$Sprite.modulate  = Color(r, g, 1.0 - r - g)

func _process(delta: float) -> void:
	
	avg_speed = lerp(avg_speed, linear_velocity.length(), delta)

func _body_entered(body):
	
	# bumper
	if body is Bumper:
		body.bump(self)
	
	# play collide sound
	_audio_on_collide.volume_linear = (2.0 / (1 + exp(-avg_speed * 0.01))) - 1.0
	_audio_on_collide.pitch_scale = randf_range(0.9, 1.0)
	_audio_on_collide.play()
