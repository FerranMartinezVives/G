#version 330 core

in vec3 frontNormal;
out vec4 fragColor;

void main() {
	fragColor = vec4(frontNormal/2.0 + vec3(0.5), 1.0);
}
