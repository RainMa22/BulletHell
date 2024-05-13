class_name BlackholeStyleManager extends StyleManager


const DOODLE_SHADER:Shader = preload("res://src/blackhole/RegularBlackhole.gdshader")

var shader_material:ShaderMaterial;

var visual: BlackHoleGravityBox
var hurtbox: BlackholeHurtBox

func _init(visual: BlackHoleGravityBox, hurtbox: BlackholeHurtBox):
	super._init()
	self.visual = visual
	self.hurtbox = hurtbox
	shader_material = ShaderMaterial.new();
	self.visual.material = shader_material;
	

func doodle_style():
	default_style() #TODO
	
func default_style():
	hurtbox.visible = false
	shader_material.set_shader(DOODLE_SHADER)
	shader_material.set_shader_parameter("ratio", visual.get_ratio())
	shader_material.set_shader_parameter("offset", visual.get_offset())
	shader_material.set_shader_parameter("event_horizon", visual.event_horizon)
	#shader_material.set_shader_parameter("strength", visual.strength)
