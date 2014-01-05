part of gwendart;

class GwenPackage
{
  String Name;
  Object UserData;
  bool IsDraggable;
  GwenControlBase DrawControl;
  Point HoldOffset;
  GwenPackage()
  {
    Name = null;
    UserData=null;
    IsDraggable=false;
    DrawControl = null;
    HoldOffset = new Point(0, 0);
  }
}