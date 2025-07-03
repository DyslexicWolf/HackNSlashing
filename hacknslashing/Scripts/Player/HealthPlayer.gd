extends Health

var immortality: bool = false : set = set_immortality, get = get_immortality
var immortality_timer: Timer = null
var current_armor: int
enum DamageType {PHYSICAL, ELEMENTAL}

func _ready() -> void:
	max_health = 3
	health = max_health

func set_health(value: int):
	#return (do nothing) if you value is lower than health (because we will have a takedamage func for that
	#or if immortality is true
	#implement immortality logic if wanted	
	
	var clamped_value = clampi(value, 0, max_health)
	if clamped_value != health:
		#calculate the healthchange
		var difference = clamped_value - health
		health = clamped_value
		health_changed.emit(difference)
		
		if health == 0:
			health_depleted.emit()


func set_immortality(value: bool):
	immortality = value

func get_immortality() -> bool:
	return immortality

func set_temporary_immortality(time: float):
	#if there isnt a timer present, create 1 with these settings
	if immortality_timer == null:
		immortality_timer = Timer.new()
		immortality_timer.one_shot = true
		add_child(immortality_timer)
	
	if immortality_timer.timeout.is_connected(set_immortality):
		immortality_timer.timeout.disconnect(set_immortality)
	
	immortality_timer.set_wait_time(time)
	#connect the timer to the setimmortality function so when it times out, we set immortality to false
	immortality_timer.timeout.connect(set_immortality.bind(false))
	immortality = true
	immortality_timer.start()


func _on_received_damage(damage: int, damage_type: DamageType) -> void:
	#temp calculation with testing values
	if damage_type == DamageType.PHYSICAL:
		var mitigation := current_armor / (current_armor + 100.0)
		var reduced_damage := damage * (1 - mitigation)
		health -= reduced_damage
	elif damage_type == DamageType.ELEMENTAL:
		#Elemental resistance can be added here if wanted
		health -= damage

func _on_constitution_changed(new_value: int) -> void:
	#temp calculation with testing values
	var base_health := 20
	var scaling := 10
	max_health = base_health + new_value * scaling

func _on_armor_changed(new_value: int) -> void:
	current_armor = new_value
