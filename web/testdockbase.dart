
import 'dart:async';
import 'src/gwendart.dart';

class TestDockBase extends DockBase
{
  static const String SkinImageFilename = "DefaultSkin.png";
   GwenControlBase _lastControl;
   double Fps;
   String Note;
   Timer _timer;
   final CanvasRenderer _cvsr;
   
   TestDockBase(CanvasRenderer cvsr, 
       GwenControlBase parent, int width, int height) : _cvsr=cvsr, super(parent)
   {
      Dock = Pos.Fill;
      SetSize(width, height);
      _timer = new Timer.periodic(new Duration(seconds: 1), timerCallback);
   }
   
   void timerCallback(Timer timer)
   {
      if(Parent != null)
      {
        if(_cvsr.IsSkinTextureLoaded)
        {
           if( Parent is GwenControlCanvas)
           {
              (Parent as GwenControlCanvas).RenderCanvas();
           }
        }
      }
   }
}