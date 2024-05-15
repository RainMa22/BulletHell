class_name PixelPerfectContainer extends SubViewportContainer

# MAIN PiXEL PERFECT SCRIPT - PIXEL PERFECT CONTAINER
# Coordinates texture and rendering, as well as the native resolution from inspector.

# INPUTS
@export var pixel_size : Vector2i = Vector2i(512, 288) # Native size (editable from inspector)

# Onready values
@onready var pixel_texture = $PixelCanvas/PixelTexture # Texture to draw pixel to
@onready var pixel_viewport = $PixelViewport # Viewport to get pixel from

@onready var scale_factor = 1 # Scale factor

# On ready, set texture rect information and call update to get accurate info
func _ready():
	# Set texture info to match this
	pixel_texture.native_size = pixel_size
	pixel_texture.scale_factor = scale_factor
	# Set the viewport to the pixel size (native size)
	pixel_viewport.size = pixel_size
	
	pixel_texture.texture = pixel_viewport.get_texture() # Assign viewport texture to render from
	pixel_texture.resize() # Resize at the start to get accurate starting dimensions
	
	# ASSIGN SELF TO PIXEL PERFECT AUTOLOAD (has to be some more elegant way later???)
	PixelPerfect.instance = self

# On scale factor changed, make sure to update to a new one in case of references
func _on_pixel_texture_scale_factor_changed(new_factor):
	scale_factor = new_factor
