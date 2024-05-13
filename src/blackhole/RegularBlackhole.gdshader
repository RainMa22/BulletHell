shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float event_horizon = 0.15;
uniform float strength = 1.0;
uniform vec2 ratio = vec2(1.0,1.0);
uniform vec2 offset = vec2(0,0);

//void vertex() {
	//// Called for every vertex the material is visible on.
//}

void fragment() {

	float x = UV.x - .5;
	float y = UV.y - .5;
	float radius = sqrt(x*x+y*y);
	float visible_horizon  = event_horizon + 0.;
	float dist_from_center = radius - visible_horizon;
	float theta = atan(y,x);
	if (dist_from_center <= 0.) {
	//if(false){
		COLOR = vec4(0.,0.,0.,1.);
	} else if(radius > .5){
		COLOR = texture(TEXTURE,UV);
		COLOR.a = 0.;
	}else {
		float delta_radius = strength*normalize(radius)*event_horizon/pow(radius,2);
		//delta_radius = dist_from_center/radius;
		//float delta_x = clamp(cos(theta)*delta_radius, -SCREEN_UV.x ,SCREEN_UV.x);
		//float delta_y = clamp(sin(theta)*delta_radius, -SCREEN_UV.y, SCREEN_UV.y);
		float delta_x = cos(theta)*delta_radius;//*-abs(x);
		float delta_y = sin(theta)*delta_radius;//*-abs(y);
		vec2 delta_uv = vec2(delta_x, delta_y)*ratio;
		COLOR = textureLod(screen_texture,SCREEN_UV-delta_uv,0.0);
		COLOR = mix(COLOR,vec4(0.,0.,0.,1.),.1);
		//COLOR = vec4(SCREEN_UV+delta_uv,0.,1.);
		//COLOR = vec4(vec3(delta_radius), 1.);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
