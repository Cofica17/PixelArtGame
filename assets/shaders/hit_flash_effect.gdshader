shader_type canvas_item;

uniform float flash = 0.0;
uniform vec4 flash_color:source_color = vec4(1.0);

void fragment() {
	vec4 previous_color = texture(TEXTURE, UV);
	COLOR = mix(previous_color, flash_color, flash);
	COLOR.a = previous_color.a;
}