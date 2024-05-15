# Pixel perfect
By Felix Liu

This is a reusable "library" which consists of code I have written to enforce a pixel perfect grid style. Includes:
	
	- Integer scaling from native resolution
	- Pixelation
	- Palette enforcement shader

SETUP - how to use:
	
	- Create an instance of pixel_perfect.tscn in your parent scene (main game scene with actual game as subscene)
	- Toggle EditableChildren
	- Add an instance of actual game underneath the PixelViewport
	- Assign desired palette to PixelPalette node
	- Set pixel_perfect.gd to autoload under the alias PixelPerfect (NOT YET IMPLEMENTED)
