shader_type canvas_item;

uniform float dist = 2.0;
uniform float opacity: hint_range(0.0, 1.0) = 0.5;

void vertex() {
	
	float v_dist = dist * TEXTURE_PIXEL_SIZE.y + 1.0;
	
	//vec2 down = (vec4(0.0, 1.0, 0.0, 1.0) * MODEL_MATRIX).xy; // TODO implement for rotation accuracy
	
	VERTEX.y *= v_dist;
	VERTEX.y += (v_dist - 1.0) / TEXTURE_PIXEL_SIZE.y / 2.0;
}

void fragment() {
	
	float v_dist = dist * TEXTURE_PIXEL_SIZE.y + 1.0;
	
	COLOR = texture(TEXTURE, vec2(UV.x, UV.y * v_dist - v_dist + 1.0));
	COLOR.rgb *= 0.0;
	COLOR.a *= opacity;
	
	COLOR += texture(TEXTURE, vec2(UV.x, UV.y * v_dist)) * (1.0 - step(1.0, UV.y * v_dist));
}
