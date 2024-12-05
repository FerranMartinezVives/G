#version 330 core

in vec4 gfrontColor;
in vec3 gNormal;
in vec2 gtexCoord;
out vec4 fragColor;

const vec3 red = vec3(1, 0, 0);
const vec3 green = vec3(0, 1, 0);
const vec3 blue = vec3(0, 0, 1);
const vec3 cyan = vec3(0, 1, 1);
const vec3 yellow = vec3(1, 1, 0);

uniform sampler2D sampler;

void main()
{
	float r = distance(gfrontColor.xyz, red);
	float g = distance(gfrontColor.xyz, green);
	float b = distance(gfrontColor.xyz, blue);
	float c = distance(gfrontColor.xyz, cyan);
	float y = distance(gfrontColor.xyz, yellow);
	
	vec3 nearestColor = red.xyz;
	float minDist = r;
	
	if (g < minDist) {
		nearestColor = green.xyz;
		minDist = g;
	}
	if (b < minDist) {
		nearestColor = blue.xyz;
		minDist = b;
	}
	if (c < minDist) {
		nearestColor = cyan.xyz;
		minDist = c;
	}
	if (y < minDist) {
		nearestColor = yellow.xyz;
		minDist = y;
	}
	
	if (gtexCoord.s >= 0 && gtexCoord.t >= 0) nearestColor *= texture(sampler, gtexCoord).xyz;
	
    	fragColor = vec4(nearestColor * (gNormal).z, 1.0);
}
