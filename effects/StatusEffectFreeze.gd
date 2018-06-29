extends "res://effects/StatusEffect.gd"

export (PackedScene) var StatusEffektSlow
export (PackedScene) var bullet
var first_time = true

signal shoot

var old_red = 0

func _init():
	$Tags.add_tag($Tags.e_tags.speed)
	$Tags.add_tag($Tags.e_tags.cast_on_death)
	StatusEffektSlow = load("res://Rune/RuneAddSlow.tscn")
	
func effekt(value, tag):
	if first_time:
		first_time = false
		old_red = get_parent().get_node("Sprite").modulate.r
		get_parent().get_node("Sprite").modulate.r = 0
		#$Sprite.modulate.r = 0
		
	if tag == $Tags.e_tags.speed:
		return 0
	if tag == $Tags.e_tags.cast_on_death:		
		shoot()
	return value
		
func _on_Duration_timeout():
	get_parent().get_node("Sprite").modulate.r = old_red
	delteYou()
	
func shoot():
	self.connect("shoot", self.get_tree().get_current_scene(), "_on_Tower_shoot")
	var b 
	var dir
	var runnes = []
	
	for x in range(0,6):
		dir = Vector2(1, 0).rotated(x)
		b = bullet.instance()
		runnes.clear()
		runnes.append(StatusEffektSlow.instance())
		b.get_node("Sprite").texture = $Ice.texture
		b.get_node("Sprite").region_rect  = $Ice.region_rect
		b.set_runes(runnes, null)
		b.effect_lifetime(0.4) 
		b.effect_speed(b.get_speed()/2)
		emit_signal('shoot', b, get_parent().global_position, dir)