extends Boon

# hidden boon that implements the default point behaviour (i.e. giving points on match)

func _on_beans_matched(_color: Bean.BeanColor) -> bool:
	
	get_parent().add_points(5)
	
	return true
