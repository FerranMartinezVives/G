#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

uniform mat4 modelViewProjectionMatrix;

in vec4 vfrontColor[];
in vec2 vtexCoord[];
out vec4 gfrontColor;
out vec2 gtexCoord;

uniform int mode = 1;
uniform float cut = -0.25;

vec3 getCentreTriangle(vec3 v1, vec3 v2, vec3 v3) {
	float Gx = (v1.x+v2.x+v3.x) / 3;
	float Gy = (v1.y+v2.y+v3.y) / 3;
	float Gz = (v1.z+v2.z+v3.z) /3;
	return vec3(Gx, Gy, Gz);
}

vec3 getFrontColor1(vec3 centre) {
	return (centre/2)+0.5;
}

void main( void )
{
	vec3 centre = getCentreTriangle(gl_in[0].gl_Position.xyz, gl_in[1].gl_Position.xyz, gl_in[2].gl_Position.xyz);
	
	if (mode < 3 || centre.x < cut || centre.y < cut || centre.z < cut) {
	gfrontColor = vec4(getFrontColor1(centre), 1);
	
	vec3 v1 = vec3(centre.x-0.08, centre.y-0.08, centre.z-0.08);
	vec3 v2 = vec3(centre.x-0.08, centre.y-0.08, centre.z+0.08);
	vec3 v3 = vec3(centre.x+0.08, centre.y-0.08, centre.z-0.08);
	vec3 v4 = vec3(centre.x+0.08, centre.y-0.08, centre.z+0.08);
	vec3 v5 = vec3(centre.x+0.08, centre.y+0.08, centre.z-0.08);
	vec3 v6 = vec3(centre.x+0.08, centre.y+0.08, centre.z+0.08);
	vec3 v7 = vec3(centre.x-0.08, centre.y+0.08, centre.z-0.08);
	vec3 v8 = vec3(centre.x-0.08, centre.y+0.08, centre.z+0.08);
	
	//strip1
	gl_Position = modelViewProjectionMatrix * vec4(v1, 1);
	gtexCoord = vec2(0, 0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v2, 1);
	gtexCoord = vec2(0, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v3, 1);
	gtexCoord = vec2(1, 0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v4, 1);
	gtexCoord = vec2(1, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v5, 1);
	gtexCoord = vec2(0, 0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v6, 1);
	gtexCoord = vec2(0, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v7, 1);
	gtexCoord = vec2(1, 0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v8, 1);
	gtexCoord = vec2(1, 1);
	EmitVertex();
	EndPrimitive();
	
	//strip2
	gl_Position = modelViewProjectionMatrix * vec4(v3, 1);
	gtexCoord = vec2(0, 0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v5, 1);
	gtexCoord = vec2(0, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v1, 1);
	gtexCoord = vec2(1, 0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v7, 1);
	gtexCoord = vec2(1, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v2, 1);
	gtexCoord = vec2(0, 0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v8, 1);
	gtexCoord = vec2(0, 1);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v4, 1);
	gtexCoord = vec2(1, 0);
	EmitVertex();
	gl_Position = modelViewProjectionMatrix * vec4(v6, 1);
	gtexCoord = vec2(1, 1);
	EmitVertex();	
    	EndPrimitive();
    	}
}
