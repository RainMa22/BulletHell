class_name BlackholeHurtBox extends EffectArea



# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready() # Replace with function body.

	
func _on_area_entered(body: Bullet):
	body.destroy_self()

func _on_area_exited(body):
	return#collide_with_body(body)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

