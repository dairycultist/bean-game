shader_type canvas_item;

uniform int dist = 2;
uniform float opacity: hint_range(0.0, 1.0) = 0.5;

varying vec2 main_uv;
varying vec2 shadow_uv;

void vertex() {
	
	vec2 uv = TEXTURE_PIXEL_SIZE * float(dist * 2);
	
	vec2 uv_half = uv * 0.5;
	vec2 uv_dist = uv + 1.0;
	
	vec2 down = (vec4(0.0, 1.0, 0.0, 1.0) * MODEL_MATRIX).xy;
	
	VERTEX *= uv_dist;
	
	main_uv = UV * uv_dist - uv_half;
	shadow_uv = main_uv - down * uv_half;
}

void fragment() {
	
	// sample colors for shadow
	COLOR = texture(TEXTURE, shadow_uv)
		* step(-1.0, -shadow_uv.x)
		* step(-1.0, -shadow_uv.y)
		* step(0.0, shadow_uv.x)
		* step(0.0, shadow_uv.y);
	
	// turn shadow colors black + opacity
	COLOR.rgb *= 0.0;
	COLOR.a *= opacity;
	
	// sample main colors on top of shadow
	COLOR += texture(TEXTURE, main_uv)
		* step(-1.0, -main_uv.x)
		* step(-1.0, -main_uv.y)
		* step(0.0, main_uv.x)
		* step(0.0, main_uv.y);
}
