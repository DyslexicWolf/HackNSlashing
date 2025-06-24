class_name HitBox
extends Area2D

enum DamageType {PHYSICAL, ELEMENTAL}
var damage: int : set = set_damage, get = get_damage
var damage_type: DamageType : set = set_damage_type, get = get_damage_type

func set_damage(value: int):
	damage = value

func get_damage() -> int:
	return damage

func set_damage_type(type : DamageType):
	damage_type = type

func get_damage_type() -> DamageType:
	return damage_type
