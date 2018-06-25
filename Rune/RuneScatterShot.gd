extends "res://Rune/RuneEffect.gd"


export (float) var scatter

func _ready():
	_init()

func _init():
	tags.append(e_runeTag.shoot)

func effect(_obj):
	sort_Obj(_obj)
	
func shoot(_sig, _bullet, _pos, _dir):
	tower.emit_shoot(_sig, _bullet.duplicate(DUPLICATE_USE_INSTANCING), _pos, _dir.rotated(-scatter))
	tower.emit_shoot(_sig, _bullet.duplicate(DUPLICATE_USE_INSTANCING), _pos, _dir.rotated(scatter))
	