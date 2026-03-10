shader_type canvas_item;

uniform int dist = 2;
uniform float opacity: hint_range(0.0, 1.0) = 0.5;

varying vec2 main_uv;
varying vec2 shadow_uv;

void vertex() {
	
	float uv_dist = float(dist * 2) * TEXTURE_PIXEL_SIZE.y + 1.0;
	
	vec2 down = (vec4(0.0, 1.0, 0.0, 1.0) * MODEL_MATRIX).xy;
	
	VERTEX *= uv_dist;
	
	main_uv = UV * uv_dist - (uv_dist - 1.0) / 2.0;
	shadow_uv = main_uv - down * (uv_dist - 1.0) / 2.0;
}

void fragment() {
	
	COLOR = texture(TEXTURE, shadow_uv)
		* step(-1.0, -shadow_uv.x)
		* step(-1.0, -shadow_uv.y)
		* step(0.0, shadow_uv.x)
		* step(0.0, shadow_uv.y);
	
	COLOR.rgb *= 0.0;
	COLOR.a *= opacity;
	
	COLOR += texture(TEXTURE, main_uv)
		* step(-1.0, -main_uv.x)
		* step(-1.0, -main_uv.y)
		* step(0.0, main_uv.x)
		* step(0.0, main_uv.y);
}
