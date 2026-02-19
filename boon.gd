extends Node

# BOONS:
# When a bean is dropped, add a point for every bean in the jar.
# When a bean is dropped, add a point for every bean of the same color in the jar.
# When two beans match, convert another bean already in the jar to the color of the matched beans.
# When two beans match, add another bean of the same color as the matched beans.
# When two beans match, add a bean with a random color.
# When two beans match, add a point for every bean in the jar.
# +5 points per match.
# +1 drop.
# If drops reach zero, the jar is shaken and allowed to settle.
# Double the likelihood of the drawn bean being [COLOR].
# [COLOR] beans give double points when merged.
# [COLOR] beans give double points when merged; color changes at the start of each round.
# The drawn bean cannot be the color there is the least of in the jar (ties pick randomly).
# Add a point for every bean that escapes the jar.

# boons connect to signals and use the parameters to determine if they should go off
# boons are children of the score node (this global class connects them to bean events)

# there's a hidden boon that implements the default point behaviour (i.e. giving points on match)
