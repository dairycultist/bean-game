shader_type canvas_item;

uniform sampler3D noise;
uniform float scale = 3.0;
uniform float speed = 0.01;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	COLOR = texture(noise, mod(vec3(UV * scale + TIME * speed, TIME * speed * 3.0), 1.0));
}