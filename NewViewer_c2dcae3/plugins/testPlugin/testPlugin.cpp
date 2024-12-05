#include "testPlugin.h"
#include "glwidget.h"

void TestPlugin::onPluginLoad()
{
	
}

void TestPlugin::preFrame()
{
	glDisable(GL_DEPTH_TEST);
	glBlendEquation(GL_FUNC_ADD);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_BLEND);
}

void TestPlugin::postFrame()
{
	
}

void TestPlugin::onObjectAdd()
{
	
}

bool TestPlugin::drawScene()
{
	return false; // return true only if implemented
}

bool TestPlugin::drawObject(int)
{
	return false; // return true only if implemented
}

bool TestPlugin::paintGL()
{
	return false; // return true only if implemented
}

void TestPlugin::keyPressEvent(QKeyEvent *)
{
	
}

void TestPlugin::mouseMoveEvent(QMouseEvent *)
{
	
}

