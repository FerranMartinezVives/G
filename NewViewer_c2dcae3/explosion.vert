#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform sampler2D colorMap;
uniform float time;

void main()
{
	float slice = 1.0 / 30.0;
	int numFrame = int(time / slice) % 48;
	int fila = 5 - numFrame / 8;
	int columna = numFrame % 8;
	
	vec2 texPos = texCoord;
	texPos.s *= 1.0/8.0;
	texPos.t *= 1.0/6.0;
	
	texPos.s += columna/8.0;
	texPos.t += fila/6.0;
	
    vtexCoord = texPos;
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
