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
	float Yangle = 0.5 * time;
	mat3 rotationMatrix = mat3(vec3(cos(Yangle), 0.0, -1.0 * sin(Yangle)), vec3(0.0, 1.0, 0.0), vec3(sin(Yangle), 0.0, cos(Yangle)));
	return rotationMatrix * vrtx;
}

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    gl_Position = modelViewProjectionMatrix * vec4(rotateVertex(vertex), 1.0);
}
