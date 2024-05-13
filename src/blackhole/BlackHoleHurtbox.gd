class_name BlackholeHurtBox extends EffectArea



var explosion = preload("res://src/vfx/Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready() # Replace with function body.

	
func _on_area_entered(body: Bullet):
	Global.popup_manager.create_popup(str(0), body.global_position, body.velocity.x)
	CameraShake.add_trauma(0.1)
	
	var new_explosion = explosion.instantiate()
	get_parent().add_child(new_explosion)
	new_explosion.global_position = global_position
	
	body.destroy_self()

func _on_area_exited(body):
	return#collide_with_body(body)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

