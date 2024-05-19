class_name Melt extends Sprite2D

@onready var shader: Shader = load("res://src/transitions/melt/Melt.gdshader")
@onready var shaderMaterial = ShaderMaterial.new()

var lifetime := 0.0;
@export var pause_time := 1.0;
@export var max_lifetime := 1.0;
@export var swipe_up :bool= false;
# Called when the node enters the scene tree for the first time.
func _ready():
	self.material = shaderMaterial
	shaderMaterial.set_shader(shader)
	var tween:Tween = get_tree().create_tween();
	tween.tween_interval(pause_time)
	tween.tween_property(self, "lifetime", 1.0, max_lifetime)
	tween.tween_callback(queue_free)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shaderMaterial.set_shader_parameter("current_time", lifetime)
	shaderMaterial.set_shader_parameter("swipe_up", swipe_up)
	
