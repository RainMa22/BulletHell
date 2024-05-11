class_name RandomPattern extends Pattern

var rng

func _init(enemy:Enemy, times_per_pattern, times_per_bullet):
	super(enemy, times_per_pattern, times_per_bullet)
	self.rng = RandomNumberGenerator.new()
	
func _process_pattern(delta):
	lifetime_accumulator += delta
	bullet_accumulator += delta
	if bullet_accumulator > times_per_bullet:
		bullet_accumulator -= times_per_bullet
		var bullet_copy = bullet.instantiate();
		var direction = Vector2(rng.randf_range(-1,1),rng.randf_range(-1,1)).normalized()
		bullet_copy.starting_direction = direction
		add_child(bullet_copy)
	super._process_pattern(delta)
