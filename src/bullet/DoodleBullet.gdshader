shader_type canvas_item;

// DOODLE BULLET
// Circular bullet design that has wiggly outline.

// COLOURING
uniform vec4 body_color = vec4(1.); // inner radius
uniform vec4 rim_color = vec4(0,0,0,1.); // outer radius
uniform vec4 outline_color = vec4(0,0,0,1.); // the circle around it

// NOISE
uniform float change_frequency = 1.0;
uniform float ID = 1.;

// RADIUS
uniform float body_radius_percentage = 0.1;
uniform float rim_radius_percentage = 0.3;
uniform float outline_extrusion_percentage = 0.05;
uniform float outline_radius_percentage = 0.05;

// RANDOM GENERATOR
float rand(float x){
	return fract(sin(dot(x,0.1))*43758.5453);
}
// COSINE INTERPOLATION IMPLEMENTATION
float cosine_interpolation(float a, float b, float dist_from_a, float size){
	float x = dist_from_a/size;
	float x2 =(1.0-cos(PI*x))/2.;
	return a*(1.-x2)+b*(x2);
}
// 1 - dimension perlin - sort-of
float smoothrand(float x){
	float size = 2.;
	
	float a_point = floor(x/size)*size;
	float dist_from_a = x - a_point;
	float a_y = rand(a_point);
	float b_point = ceil(x/size)*size;
	float b_y = rand(b_point);

	return cosine_interpolation(abs(a_y),abs(b_y),dist_from_a, size);
}
// NOISE
float noise(float x) {
	return (smoothrand(x)+smoothrand(x*1.1)+smoothrand(x*0.9))/3.;
}



// MAIN COLOUR SHADER
void fragment() {
	// UV and RADIUS, THETA calculations
	float x = UV.x-.5;
	float y = UV.y-.5;
	float radius = sqrt(x*x + y*y);
	float theta = (atan(y,x));
	
	float alpha = 1.0;
	float variant_num = floor(TIME*changes_per_second + ID);
	
	float interior_outline_noise = noise(variant_num*7.)/20.;
	
	float body = outline_inner_percentage + interior_outline_noise;
	
	float exterior_outline_noise = noise(variant_num*13.)/40.;
	float outline_size = outline_outer_percentage + exterior_outline_noise;
	
	float offset = (noise(sin(theta*2.)*TAU-variant_num*7.))/10.;
	float offset2 = (noise(sin(theta*1.5)*TAU-variant_num*13.))/16.;
	
	float min_outline_rim_radius = outline_size + exterior_rim_extrusion_percentage + offset2;
	float max_outline_rim_radius = outline_size + exterior_rim_extrusion_percentage + exterior_rim_width_percentage + offset2;
	
	// Radius less than body range
	if(radius < body + offset){
		COLOR = body_color;
	} else if (radius < outline_size + offset2){ // Radius less than outline range
		//alpha = 1.0;
		COLOR = outline_color;
	} else if (radius < max_outline_rim_radius && radius > min_outline_rim_radius) {
		COLOR = exterior_rim_color;
	} else {
		COLOR = vec4(0.);
	}
	//COLOR = vec4(UV, 1, 1);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
