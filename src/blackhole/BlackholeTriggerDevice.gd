class_name BlackholeTriggerDevice extends Bullet


func _ready():
	super._ready()
	var tween_x: Tween = self.create_tween()
	var tween_y: Tween = self.create_tween()
	tween_x.tween_property(self,"position:x", get_window().content_scale_size.x/2, .5)
	tween_y.tween_property(self,"position:y", get_window().content_scale_size.y/2, .5)
	tween_x.tween_callback(summon_blackhole)
	tween_x.tween_callback(destroy_self)
	
func summon_blackhole():
	#TODO
	print("summon a blackhole!")
	pass

func _physics_process(delta):
	return
