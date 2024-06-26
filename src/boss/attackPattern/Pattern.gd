class_name Pattern

var times_per_pattern: float
var times_per_bullet: float

var lifetime_accumulator: float
var bullet_accumulator: float
var enemy: Enemy

var bullet = preload("res://src/bullet/EnemyBullet.tscn")


func _init(enemy: Enemy, times_per_pattern, times_per_bullet):
	self.times_per_pattern = times_per_pattern
	self.times_per_bullet = times_per_bullet
	self.enemy = enemy
	reset()

func reset():
	lifetime_accumulator = 0.0
	bullet_accumulator = 0.0

func is_done():
	return lifetime_accumulator >= times_per_pattern

func time_remaining():
	return times_per_pattern - lifetime_accumulator

func set_bullet(bullet: Node):
	self.bullet = bullet

func add_child(item: Node):
	enemy.get_parent().add_child(item)
	item.global_position = enemy.global_position

func _process_pattern(delta):
	if is_done():
		enemy.on_pattern_done()

	
	
