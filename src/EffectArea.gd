class_name EffectArea extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered) # Replace with function body.
	area_exited.connect(_on_area_exited) # Replace with function body. # Replace with function body.

func _on_area_entered(body):
	push_error("please override EffectArea._on_area_entered() ")

func _on_area_exited(body):
	push_error("please override EffectArea._on_area_exited() ")
	#collide_with_body(body)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
