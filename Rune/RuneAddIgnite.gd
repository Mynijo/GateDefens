extends "res://Rune/Rune.gd"

export (PackedScene) var status

func effect(_obj):
	if _obj.has_method('add_Status'):
		var s = status.instance()
		s._init()
		s.add_tag(s.e_tags.dontStack)
		_obj.add_Status(s)