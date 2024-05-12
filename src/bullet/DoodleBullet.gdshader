shader_type canvas_item;

uniform vec4 color = vec4(1.);
uniform vec4 outline = vec4(0,0,0,1.);


float rand(float x){
	return fract(sin(x)*1000000.23);
}



float cosine_interpolation(float a, float b, float dist_from_a, float size){
	float x = dist_from_a/size;
	float x2 =(1.0-cos(PI*x))/2.;
	return a*(1.-x2)+b*(x2);
	//return (a-b)*x;
}

//1 - dimension perlin - sort-of
float smoothrand(float x){
	float size = 1./8.;
	
	float a_point = floor(x/size)*size;
	float dist_from_a = x - a_point;
	float a_y = rand(a_point);
	float b_point = ceil(x/size)*size;
	float b_y = rand(b_point);

	return cosine_interpolation(abs(a_y),abs(b_y),dist_from_a, size);
}

void fragment() {
	float x = UV.x-.5;
	float y = UV.y-.5;
	float radius = sqrt(x*x + y*y);
	float theta = atan(y, x);
	if(theta < 0.) theta += TAU;
	float alpha = 1.0;
	float offset = smoothrand(theta*SCREEN_UV.y*SCREEN_UV.x)/32.;
	float offset2 = smoothrand(theta*SCREEN_UV.y)/32.;
	
	if(radius < .35 + offset){
		COLOR = color;
	
	} else if(radius < .45 + offset2){
		//alpha = 1.0;
		COLOR = outline;
	} else {
		COLOR = vec4(0.);
	}
	//COLOR = vec4(UV, 1, 1);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
