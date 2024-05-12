class_name BlackholeHurtBox extends Bullet


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready() # Replace with function body.
	style_manager = StyleManager.new() #TODO
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_starting_velocity() -> void:
	velocity = Vector2(0,0) # Set the velocity upon entering the tree.

func _exit_tree():
	print("what")
