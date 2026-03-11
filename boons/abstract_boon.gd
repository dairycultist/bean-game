@abstract
extends Sprite2D
class_name Boon

# plinko but with jelly beans and instead of a giraffe it's a smiley anime girl
# with huge boobs

# number go up + clink clink clink sounds + many rigidbodies = stimming

# arcade game where u have 3 minutes to launch as many beans as possible, buy
# upgrades (randomly presented, by choice bought), and fatten the wife (simpler
# than full runs like balatro)

# the beans feed the wife and become the currency you buy stuff with, but when
# they're falling and hitting pegs they gain you points which contribute to your
# final score

# pegs break after a few hits, and once you clear all the pegs new ones show up
# TODO add sprites for pegs in various states of breaking

# TODO add boon animation for idling and triggering? show boons you got at end of game?

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

# BOONS (upgrades):
# Hitting pegs gives double points.
# Escaped/destroyed beans give double beans.
# Escaped/destroyed beans give +5 points.
# When the round starts, convert a random peg to a duplicate peg.
# Decrease drop cooldown by 0.1s.

# boons connect to signals and use the parameters to determine if they should go off
# boons are children of the score node (this global class connects them to bean events)
