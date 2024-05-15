class_name PixelPerfectPalette extends Node

# PIXEL PERFECT PALETTE
# Pass in an image containing the colour palette. Processes the colour palette into a list of colours and passes it to the shader.

@export var palette_image : Texture2D # Image reference to create palette
@export var target_texture : PixelPerfectRect # Texture rect to render to

var colour_palette

# On start, generate the palette and assign it to the target texture
func _ready():
	colour_palette = generate_palette(palette_image)
	assign_to_target_texture(colour_palette)

# GENERATE the colour palette array with a texture
func generate_palette(source : Texture2D):
	var data = source.get_image() # Get pixels
	var dimensions := Vector2i(palette_image.get_width(), palette_image.get_height()); # Get dimensions
	var unique_colours = [] # Setup empty list
	
	for x in range(dimensions.x):
		for y in range(dimensions.y):
			if data.get_pixel(x,y) in unique_colours: # If it's already here, skip this iteration
				continue
			unique_colours.append(data.get_pixel(x,y))
	
	return unique_colours # Return filled list

# ASSIGN to the target texture
func assign_to_target_texture(palette):
	# Assign to shader!
	target_texture.get_material().set_shader_parameter("palette_colours", palette)
	target_texture.get_material().set_shader_parameter("palette_size", len(palette))
