#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;
uniform mat4 modelViewProjectionMatrix;

vec3 black = vec3(0, 0, 0);
vec3 cyan = vec3(0, 1, 1);

void main( void )
{
	for( int i = 0 ; i < 3 ; i++ )
	{
		gfrontColor = vfrontColor[i];
		gl_Position = modelViewProjectionMatrix * gl_in[i].gl_Position;
		EmitVertex();
	}
	EndPrimitive();
	
	for (int i = 0; i < 3; ++i) {
		gfrontColor = vec4(black, 1);
		gl_Position = gl_in[i].gl_Position;
		gl_Position.y = boundingBoxMin.y;
		gl_Position = modelViewProjectionMatrix * gl_Position;
		EmitVertex();
	}
	EndPrimitive();
	
	if (gl_PrimitiveIDIn == 0) {
		gfrontColor = vec4(cyan, 1);
		float R = distance(boundingBoxMin, boundingBoxMax) / 2.0;
		vec3 C = (boundingBoxMax + boundingBoxMin) / 2.0;
		
		gl_Position = vec4(C.x-R, boundingBoxMin.y-0.01, C.z-R, 1.0);
		gl_Position = modelViewProjectionMatrix * gl_Position;
		EmitVertex();
		gl_Position = vec4(C.x+R, boundingBoxMin.y-0.01, C.z-R, 1.0);
		gl_Position = modelViewProjectionMatrix * gl_Position;
		EmitVertex();
		gl_Position = vec4(C.x-R, boundingBoxMin.y-0.01, C.z+R, 1.0);
		gl_Position = modelViewProjectionMatrix * gl_Position;
		EmitVertex();
		gl_Position = vec4(C.x+R, boundingBoxMin.y-0.01, C.z+R, 1.0);
		gl_Position = modelViewProjectionMatrix * gl_Position;
		EmitVertex();
		EndPrimitive();
	}
}
