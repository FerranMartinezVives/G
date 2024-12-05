#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float time;

vec3 rotateVertex(vec3 vrtx) {
	float Xangle = (vrtx.y - 0.5) * sin(time);
	if (vrtx.y < 0.5) Xangle = 0.0;
	mat3 rotationMatrix = mat3(vec3(1.0, 0.0, 0.0), vec3(0.0, cos(Xangle), sin(Xangle)), vec3(0.0, -1.0 * sin(Xangle), cos(Xangle)));
	return rotationMatrix * (vrtx - vec3(0.0, 1.0, 0.0)) + vec3(0.0, 1.0, 0.0);
}

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(rotateVertex(vertex), 1.0);
}
