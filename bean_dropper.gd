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

func _process(_delta: float) -> void:
	
	var bound = collider.shape.size.x / 2
	the_bean.global_position.x = clamp((camera.get_local_mouse_position() + camera.position).x, -bound, bound)

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int):

	if event.is_action_pressed("click"):
		
		# drop the_bean
		the_bean.collision_layer = 1
		the_bean.freeze = false
		
		BeanSignals.on_bean_dropped.emit(the_bean)
		
		# make a new the_bean
		the_bean = bean.instantiate()
		add_child(the_bean)
		the_bean.global_position.y = get_parent().global_position.y
		the_bean.collision_layer = 0
		the_bean.freeze = true
