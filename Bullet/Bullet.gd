extends Area2D

export (int) var speed
var speed_effected
export (float) var damage
var damage_effected
export (float) var lifetime
var lifetime_effected
export (float) var crit_chance
var crit_chance_effected


var velocity = Vector2()
var runes = []
var runes_screen = []
var status = []

var explose_after_hit = []
var explose = []

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$Lifetime.wait_time = get_lifetime()
	velocity = _direction * get_speed()
	$Lifetime.start()

func _process(delta):
	for r in runes:
		if r.has_tag($Tags.e_rune_tag.whlie_flying):			
			if !r.effect(self, $Tags.e_rune_tag.whlie_flying):
				return
	position += velocity * delta

func explode():
	for r in runes:
		var temp = r.get_tags()
		if r.has_tag($Tags.e_rune_tag.explode):
			if !r.effect(self, $Tags.e_rune_tag.explode):
				return
	queue_free()
	
func _on_Bullet_body_entered(body):
	if body.has_method('add_Status'):
		for s in status:
			body.add_Status(s.duplicate(DUPLICATE_USE_INSTANCING))		
	if body.has_method('take_damage'):
	    body.take_damage(calcDmg(body))
	
	var result 
	for r in runes:
		if r.has_tag($Tags.e_rune_tag.enemy_was_hit):			
			if !r.effect(body, $Tags.e_rune_tag.enemy_was_hit): # continue?
				return
	explode()
	
func _on_Lifetime_timeout():
	explode()

func calcDmg(body):
	var dmg = get_damage()
	if rand_range(0, 100) < get_crit_chance():
		dmg *= 2
		for r in runes:
			if r.has_tag($Tags.e_rune_tag.enemy_was_crit):
				r.enemy_was_crit(body)
	return dmg		

func add_Status(_status):
	status.append(_status)	

func set_explose_after_hit(_who, _flag):
	if _flag:
		explose_after_hit.erase(_who)
	else:
		explose_after_hit.append(_who)

func set_explose(_who, _flag):
	if _flag:
		explose.erase(_who)
	else:
		explose.append(_who)

func set_runes(_runes, _tower):
	var rune
	for r in _runes:
		rune = r.duplicate(DUPLICATE_USE_INSTANCING)
		add_child(rune)
		rune._init()
		if rune.has_tag($Tags.e_rune_tag.init_tower):
			rune.effect(_tower, $Tags.e_rune_tag.init_tower)
		runes.append(rune)
	init_runes()

func init_runes():
	for r in runes:		
		if r.has_tag($Tags.e_rune_tag.init_bullet):
			r.effect(self, $Tags.e_rune_tag.init_bullet)
		if r.has_tag($Tags.e_rune_tag.effect_bullet):
			r.effect(self, $Tags.e_rune_tag.effect_bullet)

func get_lifetime():
	if lifetime_effected:
		return lifetime_effected
	return lifetime
func effect_lifetime(_lifetime):
	lifetime_effected = _lifetime

func get_speed():
	if speed_effected:
	 return speed_effected
	return speed
func effect_speed(_speed):
	speed_effected = _speed

func get_damage():
	if damage_effected:
		return damage_effected
	return damage
func effect_damage(_damage):
	damage_effected = _damage

func get_crit_chance():
	if crit_chance_effected:
		return crit_chance_effected
	return crit_chance
func effect_crit_chance(_crit_chance):
	crit_chance_effected = _crit_chance

func is_Bullet():
	return true

