extends Node2D

@export var bean: PackedScene
@export var camera: Camera2D

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int):

	if event.is_action_pressed("click"):
		var the_bean := bean.instantiate()
		add_child(the_bean)
		the_bean.set_color()
		the_bean.global_position = camera.get_local_mouse_position() + camera.position
