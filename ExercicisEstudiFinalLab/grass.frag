#version 330 core

in vec3 gNormal;
in vec3 gPos;
out vec4 fragColor;

uniform float d;
uniform mat3 normalMatrix;

uniform sampler2D grass_side;
uniform sampler2D grass_top;

void main()
{
	if (gNormal == vec3(0)) {
		vec2 textureCoord = vec2(4*(gPos.x-gPos.y), 1.0-gPos.z/d);
		fragColor = texture(grass_side, textureCoord);
		if (fragColor.a < 0.1) discard;
	}
	else {
		vec2 textureCoord = 4*gPos.xy;
		fragColor = texture(grass_top, textureCoord);
	}
}
