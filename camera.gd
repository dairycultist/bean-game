extends Camera2D

func _ready() -> void:
	
	zoom.x = get_viewport().get_visible_rect().size.y * 0.0023
	zoom.y = zoom.x
	
	get_viewport().size_changed.connect(func(): 
		
		zoom.x = get_viewport().get_visible_rect().size.y * 0.0023
		zoom.y = zoom.x
	)
