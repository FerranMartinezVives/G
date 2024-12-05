#version 330 core

in vec4 gfrontColor;
in vec2 gtexCoord;
out vec4 fragColor;

uniform int mode;

uniform sampler2D brush;

void main()
{
	if (mode == 2) {
		fragColor = texture(brush, gtexCoord);
		if (fragColor.a < 0.9) discard;
	}
    	else fragColor = gfrontColor;
}
