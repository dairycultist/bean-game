shader_type canvas_item;

uniform float scale = 3.0;
uniform float speed = 0.01;

void fragment() {
	
	COLOR = texture(TEXTURE, vec2(UV * scale - TIME * speed));
}