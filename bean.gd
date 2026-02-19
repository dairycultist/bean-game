extends RigidBody2D
class_name Bean

var avg_speed: float
var color: BeanColor

var _audio_on_collide: AudioStreamPlayer
var _audio_on_match: AudioStreamPlayer

enum BeanColor {
	RED, YELLOW, GREEN, BLUE, PINK
}

func _ready() -> void:
	body_entered.connect(_body_entered)
	
	_audio_on_collide = get_parent().get_node("AudioOnCollide")
	_audio_on_match   = get_parent().get_node("AudioOnMatch")

func _process(delta: float) -> void:
	avg_speed = lerp(avg_speed, linear_velocity.length(), delta)

@warning_ignore("int_as_enum_without_match")
func set_color(the_color: BeanColor = -1 as BeanColor):
	
	if the_color == -1:
		color = BeanColor.values().pick_random()
	else:
		color = the_color
	
	match (color):
		BeanColor.RED: $Sprite.modulate    = Color(1.0, 0.3, 0.2)
		BeanColor.YELLOW: $Sprite.modulate = Color(1.0, 8.0, 0.2)
		BeanColor.GREEN: $Sprite.modulate  = Color(0.1, 0.8, 0.3)
		BeanColor.BLUE: $Sprite.modulate   = Color(0.1, 0.5, 0.9)
		BeanColor.PINK: $Sprite.modulate   = Color(0.9, 0.6, 0.7)

func _body_entered(body):
	
	if body is Bean and body.color == color and not body.freeze:
		queue_free()
		body.queue_free()
		_audio_on_match.pitch_scale = randf_range(0.9, 1.0)
		_audio_on_match.play()
		return
	
	_audio_on_collide.volume_linear = (2.0 / (1 + exp(-avg_speed * 0.01))) - 1.0
	_audio_on_collide.pitch_scale = randf_range(0.9, 1.0)
	_audio_on_collide.play()
