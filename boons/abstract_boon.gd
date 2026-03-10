@abstract
extends Sprite2D
class_name Boon

# I have the idea to make plinko but with jelly beans and instead of a giraffe
# it's a smiley anime girl with huge boobs and you can send a bunch of beans at
# once and they go plink plink plink and fall into baskets at the bottom which
# give a range of points and plinking also gives a small amount of points

# currently a merging game but I think peggle would be more stimming
# number go up AND clink clink clink sounds AND many rigidbodies

# TODO add boon animation for idling and triggering

func _ready() -> void:
	
	BeanSignals.on_bean_dropped.connect(_on_bean_dropped)
	BeanSignals.on_bean_hit_peg.connect(_on_bean_hit_peg)
	BeanSignals.on_bean_in_basket.connect(_on_bean_in_basket)

func _on_bean_dropped(_bean: Bean):
	pass

func _on_bean_hit_peg(_bean: Bean, _peg: Node):
	pass

func _on_bean_in_basket(_bean: Bean, _peg: Node):
	pass

# boons work on a "pick one between each round" system
# you can only have like four boons equipped at once, but you can destroy a boon at any time

# BOONS:
# When a bean is dropped, add 1 point for every bean in the jar.
# When a bean is dropped, add 1 point for every bean of the same color in the jar.
# When two beans match, convert another bean already in the jar to the color of the matched beans.
# When two beans match, add another bean of the same color as the matched beans.
# When two beans match, add a bean with a random color.
# When two beans match, add a point for every bean in the jar.
# +5 points per match.
# +3 drops.
# If drops reach zero, the jar is shaken and allowed to settle.
# Double the likelihood of the drawn bean being [COLOR].
# [COLOR] beans give double points when merged.
# [COLOR] beans give double points when merged; color changes at the start of each round.
# The drawn bean cannot be the color there is the least of in the jar (ties pick randomly).
# The drawn bean cannot be the color there is the most of in the jar (ties pick randomly).
# Add 5 point for every bean that escapes the jar.
# If two beans match, and two other beans match within one second, add 30 points.
# Beans are bouncy.

# boons connect to signals and use the parameters to determine if they should go off
# boons are children of the score node (this global class connects them to bean events)
