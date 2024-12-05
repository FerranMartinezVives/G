#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec4 frontColor;

uniform mat3 normalMatrix;
uniform mat4 modelViewProjectionMatrix;

uniform float lambda;

const vec3 red = vec3(1, 0, 0);
const vec3 green = vec3(0, 1, 0);

void main () {
	vec3 N = normalize(normalMatrix * normal);
	frontColor = vec4(mix(red, green, lambda) * N.z, 1);
	gl_Position = modelViewProjectionMatrix * vec4(vertex, 1);
}
