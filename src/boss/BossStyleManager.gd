class_name BossStyleManager extends StyleManager

var REGULAR: Shader = preload("res://src/boss/BossPointy.gdshader")
var DOODLE: Shader = preload("res://src/boss/BossDoodle.gdshader")
var outline_color: Color;
var body_color: Color;
var body: Sprite2D;
var shader_material: ShaderMaterial;
func _init(body:Sprite2D,outline_color: Color, body_color:Color):
	super._init()
	shader_material = ShaderMaterial.new()
	self.body = body
	self.outline_color = outline_color
	self.body_color = body_color
	self.body.material = shader_material

func _is_valid():
	return is_instance_valid(body)

func doodle_style():
	shader_material.set_shader(DOODLE)
	shader_material.set_shader_parameter("outline_color", outline_color)
	
func default_style():
	shader_material.set_shader(REGULAR)
	shader_material.set_shader_parameter("outline_color", outline_color)
	shader_material.set_shader_parameter("rim_color", outline_color)
	shader_material.set_shader_parameter("body_color", body_color)
