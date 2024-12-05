// GLarena, a plugin based platform to teach OpenGL programming
// © Copyright 2012-2018, ViRVIG Research Group, UPC, https://www.virvig.eu
// 
// This file is part of GLarena
//
// GLarena is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

#include "AnimateVertices.h"
#include "glwidget.h"

void AnimateVertices::onPluginLoad()
{
	elapsedTimer.start();
    // Carregar shader, compile & link 
    QString vs_src = R"""(
    	#version 330 core
    	const float pi = 3.141592;
    	const float amplitude = 0.1;
    	const float freq = 1.0;
    	layout (location = 0) in vec3 vertex;
    	layout (location = 1) in vec3 normal;
    	layout (location = 2) in vec3 color;
    	out vec4 col;
    	uniform mat4 modelViewProjectionMatrix;
    	uniform mat3 normalMatrix;
    	uniform float time;
    	
    	vec3 moveVertex() {
    		return vertex + normal * amplitude * sin(2.0 * pi * freq * time);
    	}
    	
    	void main() {
    		vec3 N = normalize(normalMatrix * normal);
    		col = vec4(N.z, N.z, N.z, 1.0);
    		gl_Position = modelViewProjectionMatrix * vec4(moveVertex(), 1.0);
    	}
    )""";
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceCode(vs_src);
    cout << "VS log:" << vs->log().toStdString() << endl;

    QString fs_src = R"""(
    	#version 330 core
    	out vec4 fragColor;
    	in vec4 col;
    	void main() {
    		fragColor = col;
    	}
    )""";
    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceCode(fs_src);
    cout << "FS log:" << fs->log().toStdString() << endl;

    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    cout << "Link log:" << program->log().toStdString() << endl;
}

void AnimateVertices::preFrame() 
{
    // bind shader and define uniforms
    program->bind();
    program->setUniformValue("time", float(elapsedTimer.elapsed() / 1000.0f));
    QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP);
    QMatrix3x3 N = camera()->viewMatrix().normalMatrix();
    program->setUniformValue("normalMatrix", N);
}

void AnimateVertices::postFrame() 
{
    // unbind shader
    program->release();
}

