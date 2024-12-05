#include "showDegree.h"
#include "glwidget.h"

void ShowDegree::showDegree() {
	QFont font;
	int size = 20;
	font.setPixelSize(size);
	painter.begin(glwidget());
	painter.setFont(font);
	painter.drawText(0, 1*size, QString::number(degree));
	painter.end();
}

float ShowDegree::avarageDegree(const Object & object) {
	int n = object.vertices().size();
	int m = 0;
	for (const Face& face : object.faces()) {
		m += face.numVertices();
	}
	return m / n;
}

void ShowDegree::onPluginLoad()
{
	degree = avarageDegree(scene()->objects()[0]);
}

void ShowDegree::preFrame()
{
	
}

void ShowDegree::postFrame()
{
	showDegree();
}

void ShowDegree::onObjectAdd()
{
	degree = avarageDegree(scene()->objects()[0]);
}

bool ShowDegree::drawScene()
{
	return false; // return true only if implemented
}

bool ShowDegree::drawObject(int)
{
	return false; // return true only if implemented
}

bool ShowDegree::paintGL()
{
	return false; // return true only if implemented
}

void ShowDegree::keyPressEvent(QKeyEvent *)
{
	
}

void ShowDegree::mouseMoveEvent(QMouseEvent *)
{
	
}

