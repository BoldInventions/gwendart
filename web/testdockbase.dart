
import 'src/gwendart.dart';

class TestDockBase extends DockBase
{
   GwenControlBase _lastControl;
   double Fps;
   String Note;
   
   TestDockBase(GwenControlBase parent, int width, int height) : super(parent)
   {
      Dock = Pos.Fill;
      SetSize(width, height);
   }
}