#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform sampler2D noise;

uniform float time;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

void main()
{   
	float ampl = distance(boundingBoxMin, boundingBoxMax) / 10;
   	vec3 posRelativa = (vertex - boundingBoxMin) / (boundingBoxMax - boundingBoxMin);
    	vec4 color1 = texture(noise, posRelativa.xz) * ampl;
    	float T = smoothstep(0, 1, time);
    	frontColor = mix(vec4(1.0, 1.0, 1.0, 1.0), vec4(color, 1), T);
    	color1 = T * color1;
    	color1.a = 1;
    
    	gl_Position = modelViewProjectionMatrix * (color1 + vec4(vertex, 1.0));
}
