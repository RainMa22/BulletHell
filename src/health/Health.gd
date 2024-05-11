class_name Health extends Node



######################################################
# HEALTH                                             #
# Generalised health logic, for use with any entity. #
######################################################

signal on_health_damaged(change)
signal on_health_healed(change)

signal on_health_max_healed

signal on_max_health_increased(change)
signal on_max_health_decreased(change)

signal on_died
signal on_revived

# I-FRAME LOGIC
@onready var invincibility_timer = $InvincibilityTimer
var is_invincible = false
var invincibility_time = 0.2
func _on_invincibility_timer_timeout():
	is_invincible = false
func start_invincibility() -> void:
	is_invincible = true
	invincibility_timer.start(invincibility_time)



var is_dead = false

var max_health := 30:
	set(val):
		if val > max_health: # Max health increased.
			on_max_health_increased.emit(val - max_health)
		elif val < max_health: # Max health decreased.
			on_max_health_decreased.emit(max_health - val)
		
		max_health = val # Assign.
		
		if health > max_health: # Limit health to be within max_health.
			health = max_health
	get:
		return max_health

var health := 10:
	set(val):
		if is_dead: # Do not change health if the entity is dead.
			return
		
		if val > health:
			on_health_healed.emit(val - health) # Healed!
		elif val < health:
			on_health_damaged.emit(health - val) # Damaged.
		
		health = clampi(val, 0, max_health) # Clamp health between 0 and max_health.
		
		if health == max_health:
			on_health_max_healed.emit() # Healed to the MAX.
		
		if health <= 0:
			die()
	get:
		return health



func die() -> void:
	is_dead = true
	on_died.emit() # Died lmao!

func revive(restarting_health : int = 1) -> void:
	is_dead = false # Undie thyself!
	health = restarting_health # Start with some health.
	on_revived.emit() # Revived!


