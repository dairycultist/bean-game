extends RigidBody2D
class_name Bean

var _avg_speed: float

var _audio_on_collide: AudioStreamPlayer

func _ready() -> void:
	
	body_entered.connect(_body_entered)
	
	_audio_on_collide = get_parent().get_node("AudioOnCollide")
	
	# set color using OKLab
	var L := 1.0;
	var angle := randf() * PI * 2.0;
	var a := cos(angle) * 0.1;
	var b := sin(angle) * 0.1;
	
	var l_ := L + 0.3963377774 * a + 0.2158037573 * b;
	var m_ := L - 0.1055613458 * a - 0.0638541728 * b;
	var s_ := L - 0.0894841775 * a - 1.2914855480 * b;

	var l := l_*l_*l_;
	var m := m_*m_*m_;
	var s := s_*s_*s_;
	
	$Sprite.material = $Sprite.material.duplicate()
	$Sprite.material.set("shader_parameter/color", Color(
		+4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
		-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
		-0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s
	));

func _process(delta: float) -> void:
	
	_avg_speed = lerp(_avg_speed, linear_velocity.length(), delta)
	
	if position.y > 450: # TODO hardcoding bad
		
		BeanSignals.on_bean_destroyed.emit()
		queue_free()

func _body_entered(body):
	
	# hit a peg
	if body is Peg:
		body.bump(self)
	
	# play collide sound
	_audio_on_collide.volume_linear = (2.0 / (1 + exp(-_avg_speed * 0.01))) - 1.0
	_audio_on_collide.pitch_scale = randf_range(0.9, 1.0)
	_audio_on_collide.play()
