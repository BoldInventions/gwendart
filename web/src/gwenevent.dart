part of gwendart;

class GwenEventArgs
{
   static GwenEventArgs Empty = new GwenEventArgs();
   
   GwenEventArgs(){}
}

class ClickedEventArgs extends GwenEventArgs
{
   int x;
   int y;
   bool down;
   ClickedEventArgs(int _x, int _y, [ bool _down = false ])
   {
     x = _x;
     y = _y;
     down = _down;
   }
}