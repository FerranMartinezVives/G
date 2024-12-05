#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

vec3 red = vec3(1, 0, 0);
vec3 green = vec3(0, 1, 0);
vec3 blue = vec3(0, 0, 1);

bool isCameraInsideBox() {
	vec4 bBMin = modelViewMatrix * vec4(boundingBoxMin, 1);
	vec4 bBMax = modelViewMatrix * vec4(boundingBoxMax, 1);
	return (bBMin.x < 0) && (bBMax.x > 0) && (bBMin.y < 0) && (bBMax.y > 0) && (bBMin.z < 0) && (bBMax.z > 0);
}

void main( void )
{
	bool check = isCameraInsideBox();
	for( int i = 0 ; i < 3 ; i++ )
	{
		if (check) gfrontColor = 2 * vfrontColor[i];
		else gfrontColor = vfrontColor[i];
		gl_Position = gl_in[i].gl_Position;
		EmitVertex();
	}
    	EndPrimitive();
    	
    	if (gl_PrimitiveIDIn == 0) {
    		//cara1
    		vec3 v1 = boundingBoxMin;
    		vec3 v2 = vec3(boundingBoxMin.xy, boundingBoxMax.z);
    		vec3 v3 = vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMin.z);
    		vec3 v4 = vec3(boundingBoxMin.x, boundingBoxMax.yz);
    		gfrontColor = vec4(red, 1);
    		gl_Position = modelViewProjectionMatrix * vec4(v1, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v2, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v3, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v4, 1);
    		EmitVertex();
    		EndPrimitive();
    		
    		//cara2
    		v1 = boundingBoxMin;
    		v2 = vec3(boundingBoxMin.x, boundingBoxMax.y, boundingBoxMin.z);
    		v3 = vec3(boundingBoxMax.x, boundingBoxMin.yz);
    		v4 = vec3(boundingBoxMax.xy, boundingBoxMin.z);
    		gfrontColor = vec4(blue, 1);
    		gl_Position = modelViewProjectionMatrix * vec4(v1, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v2, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v3, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v4, 1);
    		EmitVertex();
    		EndPrimitive();
    		
    		//cara3
    		v1 = vec3(boundingBoxMax.x, boundingBoxMin.yz);
    		v2 = vec3(boundingBoxMax.xy, boundingBoxMin.z);
    		v3 = vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMax.z);
    		v4 = boundingBoxMax;
    		gfrontColor = vec4(red, 1);
    		gl_Position = modelViewProjectionMatrix * vec4(v1, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v2, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v3, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v4, 1);
    		EmitVertex();
    		EndPrimitive();
    		
    		//cara 4
    		v1 = boundingBoxMin;
    		v2 = vec3(boundingBoxMin.xy, boundingBoxMax.z);
    		v3 = vec3(boundingBoxMax.x, boundingBoxMin.yz);
    		v4 = vec3(boundingBoxMax.x, boundingBoxMin.y, boundingBoxMax.z);
    		gfrontColor = vec4(green, 1);
    		gl_Position = modelViewProjectionMatrix * vec4(v1, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v2, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v3, 1);
    		EmitVertex();
    		gl_Position = modelViewProjectionMatrix * vec4(v4, 1);
    		EmitVertex();
    		EndPrimitive();
    	}
}
