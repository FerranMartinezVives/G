#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec3 vNormal[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform float time;

const float speed = 1.2;

void main( void )
{
	vec3 n = (vNormal[0]+vNormal[1]+vNormal[2]) / 3.0;
	vec3 translation = speed * time * n;
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		gl_Position = gl_Position + vec4(translation, 1);
		gl_Position = modelViewProjectionMatrix * gl_Position;
		EmitVertex();
	}
    EndPrimitive();
}
