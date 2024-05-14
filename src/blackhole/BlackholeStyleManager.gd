class_name BlackholeStyleManager extends StyleManager


const REGULAR:Shader = preload("res://src/blackhole/RegularBlackhole.gdshader")
const DOODLE:Shader = preload("res://src/blackhole/DoodleBlackhole.gdshader")

var shader_material:ShaderMaterial;

var visual: BlackHoleGravityBox
var hurtbox: BlackholeHurtBox

func _init(visual: BlackHoleGravityBox, hurtbox: BlackholeHurtBox):
	super._init()
	self.visual = visual
	self.hurtbox = hurtbox
	shader_material = ShaderMaterial.new();
	self.visual.material = shader_material;
	self.hurtbox.material =shader_material;
	
func _is_valid():
	return is_instance_valid(visual)

func doodle_style():
	hurtbox.visible = false
	shader_material.set_shader(DOODLE)
	shader_material.set_shader_parameter("body_radius_percentage", visual.event_horizon)
	shader_material.set_shader_parameter("change_frequency", 1/sqrt(visual.get_ratio().x))
	shader_material.set_shader_parameter("body_color",hurtbox.modulate)
	shader_material.set_shader_parameter("rim_color",visual.modulate)
	shader_material.set_shader_parameter("outline_color",hurtbox.modulate)
	
func default_style():
	hurtbox.visible = false
	shader_material.set_shader(REGULAR)
	shader_material.set_shader_parameter("ratio", visual.get_ratio())
	shader_material.set_shader_parameter("offset", visual.get_offset())
	shader_material.set_shader_parameter("event_horizon", visual.event_horizon)
	#shader_material.set_shader_parameter("strength", visual.strength)
