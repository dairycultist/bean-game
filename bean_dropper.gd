extends Node2D

@export var bean: PackedScene
@export var camera: Camera2D

var the_bean: Bean

func _ready() -> void:
	
	the_bean = bean.instantiate()
	add_child(the_bean)
	the_bean.set_color()
	the_bean.global_position.y = -166
	the_bean.collision_layer = 0
	the_bean.freeze = true

func _process(_delta: float) -> void:
	the_bean.global_position.x = clamp((camera.get_local_mouse_position() + camera.position).x, -100, 100)

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int):

	if event.is_action_pressed("click"):
		
		# drop the_bean
		the_bean.collision_layer = 1
		the_bean.freeze = false
		
		BeanSignals.on_bean_dropped.emit(the_bean.color)
		
		# make a new the_bean
		the_bean = bean.instantiate()
		add_child(the_bean)
		the_bean.set_color()
		the_bean.global_position.y = -166
		the_bean.collision_layer = 0
		the_bean.freeze = true
