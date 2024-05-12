class_name BlackholeTriggerDevice extends Bullet

const BLACKHOLE = preload("res://src/blackhole/Blackhole.tscn")

var target:Vector2

func _init(target: Vector2 = Vector2(0,0)):
	set_target(target)

func set_target(target: Vector2):
	self.target = target

func _ready():
	super._ready()
	var tween_x: Tween = self.create_tween()
	tween_x.tween_property(self,"global_position", 
	target,.3)
	tween_x.tween_callback(summon_blackhole)
	tween_x.tween_callback(destroy_self)
	
func summon_blackhole():
	var blackhole = BLACKHOLE.instantiate();
	get_parent().add_child(blackhole);
	blackhole.global_position = self.global_position
	
	pass

func _physics_process(delta):
	return
