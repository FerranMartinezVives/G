#version 330 core

in vec4 frontPosition;
out vec4 fragColor;

void main() {
	fragColor = vec4(gl_FragCoord.z);
}
