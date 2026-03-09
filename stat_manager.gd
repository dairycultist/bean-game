extends Node2D

var point_label_anim_t := 0.0
var point_label_anim_intensity := 1.0
var points: int = 0

func _ready() -> void:
	BeanSignals.on_bean_hit_peg.connect(_on_bean_hit_peg)

func _process(delta: float) -> void:
	
	point_label_anim_t += delta * point_label_anim_intensity
	$PointLabel.rotation = sin(point_label_anim_t * 4.0) * 0.05 * point_label_anim_intensity
	
	point_label_anim_intensity = lerp(point_label_anim_intensity, 1.0, delta)

func _on_bean_hit_peg(_bean: Bean, _peg: Node) -> bool:
	
	points += 5
	$PointLabel.text = "Points: " + str(points)
	
	point_label_anim_intensity = 4.0
	
	return true
