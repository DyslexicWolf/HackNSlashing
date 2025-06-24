extends Node
class_name StatManager


#player health is based on this value
var constitution: int  : set = set_constitution, get = get_constitution
#elemental damage for special weapon effects is based on this
var intelligence: int : set = set_intelligence, get = get_intelligence
#weapon attack speed is based on this
var dexterity: int  : set = set_dexterity, get = get_dexterity
#physical damage (of normal weapon attacks) is based on this
var strength: int : set = set_strength, get = get_strength
#luck for items is based on this
var luck: int : set = set_luck, get = get_luck

var armor: int : set = set_armor, get = get_armor
var movement_speed: int : set = set_movement_speed, get = get_movement_speed
var attack_speed: int : set = set_attack_speed, get = get_attack_speed
var crit_chance: int : set = set_crit_chance, get = get_attack_speed

signal constitution_changed(new_value : int)
signal intelligence_changed(new_value : int)
signal dexterity_changed(new_value : int)
signal strength_changed(new_value : int)
signal luck_changed(new_value : int)
signal armor_changed(new_value : int)
signal movement_speed_changed(new_value : int)
signal attack_speed_changed(new_value : int)
signal crit_chance_changed(new_value : int)

#set functions for all the stats
func set_constitution(value : int):
	constitution += value
	constitution_changed.emit(constitution)

func set_intelligence(value : int):
	intelligence += value
	intelligence_changed.emit(intelligence)

func set_dexterity(value : int):
	dexterity += value
	dexterity_changed.emit(dexterity)

func set_strength(value : int):
	strength += value
	strength_changed.emit(strength)

func set_luck(value : int):
	luck += value
	luck_changed.emit(luck)

func set_armor(value : int):
	armor += value
	armor_changed.emit(armor)

func set_movement_speed(value : int):
	movement_speed += value
	movement_speed_changed.emit(movement_speed)

func set_attack_speed(value : int):
	attack_speed += value
	attack_speed_changed.emit(attack_speed)

func set_crit_chance(value : int):
	crit_chance += value
	crit_chance_changed.emit(crit_chance)


#get functions for all the stats
func get_constitution() -> int:
	return constitution

func get_intelligence() -> int:
	return intelligence

func get_dexterity() -> int:
	return dexterity

func get_strength() -> int:
	return strength

func get_luck() -> int:
	return luck

func get_armor() -> int:
	return armor

func get_movement_speed() -> int:
	return movement_speed

func get_attack_speed() -> int:
	return attack_speed

func get_crit_chance() -> int:
	return crit_chance


func _ready() -> void:
	#Set base values for all the stats, trigger signals to set initial data for other scripts depending on these stats
	constitution = 10
	intelligence = 10
	dexterity = 10
	strength = 10
	luck = 10
	armor = 15
	movement_speed = 130
	attack_speed = 1
	crit_chance = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
