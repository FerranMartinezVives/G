#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

const vec3 red = vec3(1.0, 0.0, 0.0);
const vec3 yellow = vec3(1.0, 1.0, 0.0);
const vec3 green = vec3(0.0, 1.0, 0.0);
const vec3 cyan = vec3(0.0, 1.0, 1.0);
const vec3 blue = vec3(0.0, 0.0, 1.0);

vec3 getColor(vec4 vrtx) {
	float y = 2 * (vrtx.y / vrtx.w + 1.0);
	if (y == 0) return red;
	else if (y < 1) return mix(red, yellow, fract(y));
	else if (y < 2) return mix(yellow, green, fract(y));
	else if (y < 3) return mix(green, cyan, fract(y));
	else if (y < 4) return mix(cyan, blue, fract(y));
	else return blue;
}

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
    frontColor = vec4(getColor(gl_Position),1.0);
}
