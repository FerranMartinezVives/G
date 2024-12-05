#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
in vec4 veyePos[];
out vec4 gfrontColor;

uniform mat3 normalMatrix;
uniform mat4 modelViewProjectionMatrix;

uniform float disp = 0.05;

vec3 getBaricentre (vec3 v1, vec3 v2, vec3 v3) {
	return (v1+v2+v3) / 3.0;
}

vec3 getNormal (vec3 v1, vec3 v2, vec3 v3) {
	vec3 v1v2 = normalize(v2 - v1);
	vec3 v1v3 = normalize(v3 - v1);
	return normalize(normalMatrix * normalize(cross(v1v2, v1v3)));
}

void main( void )
{
	vec3 v0 = gl_in[0].gl_Position.xyz;
	vec3 v1 = gl_in[1].gl_Position.xyz;
	vec3 v2 = gl_in[2].gl_Position.xyz;
	vec3 baricentre = getBaricentre(v0, v1, v2) + disp * getNormal(v0, v1, v2);
	
	vec3 n0 = getNormal(v0, v1, baricentre);
	vec3 n1 = getNormal(v0, v2, baricentre);
	vec3 n2 = getNormal(v1, v2, baricentre);
	
	//subtriangle1
	gfrontColor = vfrontColor[0] * n0.z;
	gl_Position = modelViewProjectionMatrix * vec4(v0, 1);
	EmitVertex();
	gfrontColor = vfrontColor[1] * n0.z;
	gl_Position = modelViewProjectionMatrix * vec4(v1, 1);
	EmitVertex();
	gfrontColor = vec4(1) * n0.z;
	gl_Position = modelViewProjectionMatrix * vec4(baricentre, 1);
	EmitVertex();
	EndPrimitive();
	
	//subtriangle2
	gfrontColor = vfrontColor[0] * n1.z;
	gl_Position = modelViewProjectionMatrix * vec4(v0, 1);
	EmitVertex();
	gfrontColor = vfrontColor[2] * n1.z;
	gl_Position = modelViewProjectionMatrix * vec4(v2, 1);
	EmitVertex();
	gfrontColor = vec4(1) * n1.z;
	gl_Position = modelViewProjectionMatrix * vec4(baricentre, 1);
	EmitVertex();
	EndPrimitive();
	
	gfrontColor = vfrontColor[1] * n2.z;
	gl_Position = modelViewProjectionMatrix * vec4(v1, 1);
	EmitVertex();
	gfrontColor = vfrontColor[2] * n2.z;
	gl_Position = modelViewProjectionMatrix * vec4(v2, 1);
	EmitVertex();
	gfrontColor = vec4(1) * n2.z;
	gl_Position = modelViewProjectionMatrix * vec4(baricentre, 1);
	EmitVertex();
	EndPrimitive();
}
