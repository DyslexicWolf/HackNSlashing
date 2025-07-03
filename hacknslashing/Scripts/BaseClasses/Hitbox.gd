extends Area2D
class_name HitBox

enum DamageType {PHYSICAL, ELEMENTAL}
var damage: int : set = set_damage, get = get_damage
var elemental_damage: int : set = set_elemental_damage, get = get_elemental_damage
var damage_type: DamageType : set = set_damage_type, get = get_damage_type

func set_damage(value: int):
	damage = value

func set_elemental_damage(value : int):
	elemental_damage = value

func set_damage_type(type : DamageType):
	damage_type = type

func get_damage() -> int:
	return damage

func get_elemental_damage() -> int:
	return elemental_damage

func get_damage_type() -> DamageType:
	return damage_type
