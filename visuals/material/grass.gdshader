shader_type spatial;
render_mode cull_disabled;

uniform sampler2D windTexture;
// global uniform sampler2D WindTexture;
uniform float speed = .1f;

void vertex(){
	vec3 vertex = VERTEX;
	float offset = texture(windTexture,UV+vec2(speed*TIME+INSTANCE_CUSTOM.x,INSTANCE_CUSTOM.z)).r;
	vertex.z = vertex.z+sin(offset)*vertex.y;
	vertex.x = vertex.x+sin(offset)*vertex.y;
	VERTEX = vertex;
}

void fragment() {
	ALBEDO = COLOR.rgb;
}
