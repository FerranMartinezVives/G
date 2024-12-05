#ifndef _DEPTHNORMAL_H
#define _DEPTHNORMAL_H

#include "plugin.h" 

class Depthnormal: public QObject, public Plugin
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "Plugin") 
	Q_INTERFACES(Plugin)

  public:
	 void onPluginLoad();
	 void preFrame();
	 void postFrame();

	 void onObjectAdd();
	 bool drawScene();
	 bool drawObject(int);

	 bool paintGL();

	 void keyPressEvent(QKeyEvent *);
	 void mouseMoveEvent(QMouseEvent *);
  private:
	void linkShadersDepth();
	void linkShadersNormal();
	QOpenGLShaderProgram* program_depth;
	QOpenGLShader* depth_vs;
	QOpenGLShader* depth_fs;
	QOpenGLShaderProgram* program_normal;
	QOpenGLShader* normal_vs;
	QOpenGLShader* normal_fs;
};

#endif
