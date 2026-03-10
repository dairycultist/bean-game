extends Node2D

@export var bean: PackedScene
@export var camera: Camera2D

var the_bean: Bean

var collider: CollisionShape2D

func _ready() -> void:
	
	the_bean = bean.instantiate()
	add_child(the_bean)
	the_bean.global_position.y = get_parent().global_position.y
	the_bean.collision_layer = 0
	the_bean.freeze = true
	
	# initialize collision
	collider = CollisionShape2D.new()
	
	add_child(collider)
	
	collider.shape = RectangleShape2D.new()
	collider.shape.size.x = get_parent().size.x
	collider.shape.size.y = get_parent().size.y
	collider.position.x = collider.shape.size.x / 2
	collider.position.y = collider.shape.size.y / 2

func _process(delta: float) -> void:
	
	var bound = collider.shape.size.x / 2
	the_bean.global_position.x = clamp((camera.get_local_mouse_position() + camera.position).x, -bound, bound)
	
	the_bean.global_position.y = lerp(the_bean.global_position.y, get_parent().global_position.y, 10.0 * delta)

	the_bean.scale.x = 1.0 + sin(Time.get_ticks_msec() * 0.01) * 0.05
	the_bean.scale.y = the_bean.scale.x

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int):

	if event.is_action_pressed("click"):
		
		# drop the_bean
		the_bean.collision_layer = 1
		the_bean.freeze = false
		the_bean.scale = Vector2.ONE
		
		BeanSignals.on_bean_dropped.emit(the_bean)
		
		# make a new the_bean
		the_bean = bean.instantiate()
		add_child(the_bean)
		the_bean.global_position.y = get_parent().global_position.y - 50.0
		the_bean.global_rotation = randf() * PI * 2
		the_bean.collision_layer = 0
		the_bean.freeze = true
