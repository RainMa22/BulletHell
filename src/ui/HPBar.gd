class_name HPBar extends ProgressBar


# Called when the node enters the scene tree for the first time.
func hp_init():
	get_parent().player.health.on_health_healed.connect(changed)
	get_parent().player.health.on_health_damaged.connect(changed)
	get_parent().player.health.on_died.connect(died)
	changed(0)

func changed(change):
	value = float(get_parent().player.health.health) / float(get_parent().player.health.max_health)

func died():
	value = 0
