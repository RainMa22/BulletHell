class_name SpiralPattern extends Pattern

const SPIRAL_MIN = 5
const SPIRAL_MAX = 9

var n_trails: int
var reversed: bool


func _init(boss:Boss, times_per_pattern, times_per_bullet, n_trails = 3, reversed = false):
	super(boss, times_per_pattern, times_per_bullet*n_trails)
	self.n_trails = n_trails
	self.reversed = reversed
	
func _process_pattern(delta):
	lifetime_accumulator += delta
	bullet_accumulator += delta
	if bullet_accumulator > times_per_bullet:
		bullet_accumulator -= times_per_bullet
		for i in range(n_trails):
			var bullet_copy = bullet.instantiate()
			var angle = TAU/5*i + Engine.get_frames_drawn()
			var direction = Vector2(cos(angle),sin(angle))
			bullet_copy.starting_direction = direction
			add_child(bullet_copy)
	super._process_pattern(delta)
