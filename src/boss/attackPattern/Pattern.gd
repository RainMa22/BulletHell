class_name Pattern

var times_per_pattern: float
var times_per_bullet: float

var lifetime_accumulator: float
var bullet_accumulator: float
var boss: Boss

var bullet = preload("res://src/bullet/EnemyBullet.tscn")


func _init(boss: Boss, times_per_pattern, times_per_bullet):
	self.times_per_pattern = times_per_pattern
	self.times_per_bullet = times_per_bullet
	self.boss = boss
	reset()

func reset():
	lifetime_accumulator = 0.0
	bullet_accumulator = 0.0

func is_done():
	return lifetime_accumulator >= times_per_pattern

func time_remaining():
	return times_per_pattern - lifetime_accumulator

func add_child(item: Node):
	boss.get_parent().add_child(item)
	item.global_position = boss.global_position

func _process_pattern(delta):
	if is_done():
		boss.on_pattern_done()

	
	
