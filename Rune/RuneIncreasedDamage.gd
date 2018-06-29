extends "res://Rune/RuneEffect.gd"

export (float) var incrase

func _init():
	$Tags.add_tag($Tags.e_rune_tag.effect_bullet)
	$Tags.add_tag($Tags.e_rune_tag.init_bullet)
	
func effect(_obj, _tag):
	if _tag == $Tags.e_rune_tag.init_bullet:
		sort_Obj(_obj)
	if _tag == $Tags.e_rune_tag.effect_bullet:
		if bullet.has_method('effect_damage'):
			bullet.effect_damage(bullet.get_damage() * incrase)