extends StaticBody2D
class_name Bumper

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func bump(bean: Bean):
	BeanSignals.on_bean_hit_peg.emit(bean, self)
	$AnimationPlayer.play("bump")
	$AnimationPlayer.seek(0)
