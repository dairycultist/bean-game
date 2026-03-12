extends Node2D

@export var bean: PackedScene
@export var camera: Camera2D

var _the_bean: Bean

var bound: float

var _dropping: bool
var _time_to_drop: float = 0.0
@export var drop_cooldown: float = 0.5

func _ready() -> void:
	
	_the_bean = bean.instantiate()
	add_child(_the_bean)
	_the_bean.global_position.y = get_parent().global_position.y
	_the_bean.collision_layer = 0
	_the_bean.freeze = true
	
	# initialize collision
	var collider := CollisionShape2D.new()
	
	add_child(collider)
	
	collider.shape = RectangleShape2D.new()
	collider.shape.size.x = get_parent().size.x
	collider.shape.size.y = get_parent().size.y
	collider.position.x = collider.shape.size.x / 2
	collider.position.y = collider.shape.size.y / 2
	
	bound = collider.shape.size.x / 2
	
	$Character.global_position.y = get_parent().global_position.y

func _process(delta: float) -> void:
	
	_the_bean.global_position.x = clamp((camera.get_local_mouse_position() + camera.position).x, -bound, bound)
	_the_bean.global_position.y = lerp(_the_bean.global_position.y, get_parent().global_position.y, 10.0 * delta)

	$Character.global_position.x = _the_bean.global_position.x

	_the_bean.scale.x = 1.0 + sin(Time.get_ticks_msec() * 0.01) * 0.05
	_the_bean.scale.y = _the_bean.scale.x
	
	_time_to_drop -= delta
	
	if _dropping and _time_to_drop < 0.0:
		
		_time_to_drop = drop_cooldown
		
		$Character/AnimationPlayer.play("throw")
		$Character/AnimationPlayer.seek(0)
		
		# drop the_bean
		_the_bean.collision_layer = 1
		_the_bean.freeze = false
		_the_bean.scale = Vector2.ONE
		
		BeanSignals.on_bean_dropped.emit(_the_bean)
		
		# make a new the_bean
		_the_bean = bean.instantiate()
		add_child(_the_bean)
		_the_bean.global_position.y = get_parent().global_position.y - 50.0
		_the_bean.global_rotation = randf() * PI * 2
		_the_bean.collision_layer = 0
		_the_bean.freeze = true

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int):

	if event.is_action_pressed("click"):
		_dropping = true

func _input(event: InputEvent) -> void:
	
	if event.is_action_released("click"):
		_dropping = false
