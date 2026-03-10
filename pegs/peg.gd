extends StaticBody2D
class_name Peg

@export var point_value: int = 5

@export_category("Effects")
@export var duplicator: bool

func bump(bean: Bean):
	
	if duplicator:
		get_node("../BeanDropper").add_child(bean.duplicate())
	
	BeanSignals.on_bean_hit_peg.emit(bean, self)
	$AnimationPlayer.play("bump")
	$AnimationPlayer.seek(0)
