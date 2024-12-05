#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;
out vec2 gtexCoord;

uniform int mode = 2;
uniform vec2 quadSize = vec2(0.2, 0.2);

uniform mat4 projectionMatrix;

vec3 getBaricentre(vec3 v0, vec3 v1, vec3 v2) {
	return (v0+v1+v2)/3.0;
}

void main( void )
{
	vec3 v0 = gl_in[0].gl_Position.xyz;
	vec3 v1 = gl_in[1].gl_Position.xyz;
	vec3 v2 = gl_in[2].gl_Position.xyz;
	
	vec3 N = normalize(cross(v1 - v0, v2 - v0));
	
	if (abs(N.z) <= 0.1) {
		if (mode == 0) {
			for (int i = 0; i < 3; i++) {
				gfrontColor = vfrontColor[i];
				gl_Position = projectionMatrix * gl_in[i].gl_Position;
				EmitVertex();
			}
			EndPrimitive();
		}
		else if (mode >= 1) {
			vec3 C = getBaricentre(v0, v1, v2);
			vec3 dx = vec3(N.x, N.y, 0);
			vec3 dy = vec3(-N.y, N.x, 0);
			
			gfrontColor = vec4(0, 0, 0, 1);
			
			gtexCoord = vec2(1, 1);
			gl_Position = projectionMatrix * vec4(C + quadSize.x * dx + quadSize.y * dy, 1);
			EmitVertex();
			
			gtexCoord = vec2(0, 1);
			gl_Position = projectionMatrix * vec4(C - quadSize.x * dx + quadSize.y * dy, 1);
			EmitVertex();
			
			gtexCoord = vec2(1, 0);
			gl_Position = projectionMatrix * vec4(C + quadSize.x * dx - quadSize.y * dy, 1);
			EmitVertex();
			
			gtexCoord = vec2(0, 0);
			gl_Position = projectionMatrix * vec4(C - quadSize.x * dx - quadSize.y * dy, 1);
			EmitVertex();
			
			EndPrimitive();
		}
	}
}
