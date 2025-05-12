extends Health

var immortality: bool = false : set = set_immortality, get = get_immortality
var immortality_timer: Timer = null

func _ready() -> void:
	max_health = 3
	health = max_health

func set_health(value: int):
	#return (do nothing) if you value is lower than health (because we will have a takedamage func for that
	#or if immortality is true
	if value < health and immortality:
		return
	
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
