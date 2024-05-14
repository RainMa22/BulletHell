class_name BlackHoleGravityBox extends EffectArea

@export var strength = 5./32
var event_horizon:float
var bodies_entered: Array

@onready var visual:Sprite2D = $Visual

func _init(event_horizon = .2):
	self.event_horizon = event_horizon
	self.bodies_entered = []

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered) # Replace with function body.
	area_exited.connect(_on_area_exited) # Replace with function body.
	pass
	#area_shape_entered.connect(_on_area_shape_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var bullet = await load("res://src/bullet/PlayerBullet.tscn")
	#var b :Bullet=bullet.instantiate()
	#b.position = Vector2(0, 128.);
	#b.starting_direction = Vector2(.25, -1)
	#add_child(b);
	pass

# COLLISION WITH BODIES (Player and Bosses, Enemies)
func _on_area_entered(body):
	bodies_entered.append(body)
	#collide_with_body(body)
#func _on_area_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#bodies_entered.append(body)
	##collide_with_body(body)
	
func _on_area_exited(body):
	bodies_entered.erase(body)
	#collide_with_body(body)
	
func euclidean_distance(v1:Vector2) -> float:
	return sqrt((v1.x)**2 + (v1.y)**2)

#var to_free: Array = [];
func _physics_process(delta):
	for body: Bullet in bodies_entered:
		collide_with_body(body, delta)
	#for body: Bullet in to_free:
		#bodies_entered.erase(body)
		#body.destroy_self()
	#to_free.clear();
#
#func queue_to_free(body: Bullet):
	#to_free.append(body)

func get_ratio() -> Vector2:
	return Vector2(1.0,1.0)/(visual.texture.get_size()*visual.global_scale)
					
func get_offset() -> Vector2:
	return Vector2(get_window().size)/visual.global_position

func collide_with_body(body: Bullet, delta):
	var dist = self.global_position - body.global_position
	var euclid_dist = euclidean_distance(dist)
	euclid_dist *= get_ratio().x
	#euclid_dist -= event_horizon
	#if euclid_dist <  0:
		#body.velocity = Vector2(0,0)
		#queue_to_free(body)
	body.velocity += strength*dist*visual.texture.get_size()*event_horizon/((euclid_dist)**2)*delta
	
