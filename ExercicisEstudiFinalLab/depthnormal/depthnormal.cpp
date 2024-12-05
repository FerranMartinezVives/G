#include "depthnormal.h"
#include "glwidget.h"

void Depthnormal::linkShadersDepth() {
	depth_vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	depth_vs->compileSourceFile("depth.vert");
	cout << "VS log: " << depth_vs->log().toStdString() << endl;
	
	depth_fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	depth_fs->compileSourceFile("depth.frag");
	cout << "FS log: " << depth_fs->log().toStdString() << endl;
	
	program_depth = new QOpenGLShaderProgram(this);
	program_depth->addShader(depth_vs);
	program_depth->addShader(depth_fs);
	program_depth->link();
	cout << "Link log: " << program_depth->log().toStdString() << endl;
}

void Depthnormal::linkShadersNormal() {
	normal_vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
	normal_vs->compileSourceFile("normal.vert");
	cout << "VS log: " << normal_vs->log().toStdString() << endl;
	
	normal_fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
	normal_fs->compileSourceFile("normal.frag");
	cout << "FS log: " << normal_fs->log().toStdString() << endl;
	
	program_normal = new QOpenGLShaderProgram(this);
	program_normal->addShader(normal_vs);
	program_normal->addShader(normal_fs);
	program_normal->link();
	cout << "Link log: " << program_normal->log().toStdString() << endl;
}

void Depthnormal::onPluginLoad()
{
	GLWidget& widget = *glwidget();
	widget.makeCurrent();
	
	linkShadersDepth();
	linkShadersNormal();
}

void Depthnormal::preFrame()
{
	
}

void Depthnormal::postFrame()
{
	
}

void Depthnormal::onObjectAdd()
{
	
}

bool Depthnormal::drawScene()
{
	return false; // return true only if implemented
}

bool Depthnormal::drawObject(int)
{
	return false; // return true only if implemented
}

bool Depthnormal::paintGL()
{
	GLWidget& widget = *glwidget();
	widget.makeCurrent();
	
	QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->viewMatrix();
	
	glViewport(0, 0, widget.width() / 2.0, widget.height());
	program_depth->bind();
	program_depth->setUniformValue("modelViewProjectionMatrix", MVP);
	if (drawPlugin()) drawPlugin()->drawScene();
	
	glViewport(widget.width() / 2.0, 0, widget.width() / 2.0, widget.height());
	program_normal->bind();
	program_normal->setUniformValue("modelViewProjectionMatrix", MVP);
	if (drawPlugin()) drawPlugin()->drawScene();
	
	return true;
}

void Depthnormal::keyPressEvent(QKeyEvent *)
{
	
}

void Depthnormal::mouseMoveEvent(QMouseEvent *)
{
	
}

