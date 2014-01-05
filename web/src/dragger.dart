part of gwendart;

class Dragger extends GwenControlBase
{
  
   bool _held;
   Point<int> _holdPos;
   GwenControlBase _base;
   
   GwenControlBase get _Target => _base;
   set _Target(GwenControlBase value) { _base = value; }
   
   bool get IsHeld => _held;
   
   GwenEventHandlerList Dragged = new GwenEventHandlerList();
  
  
   void OnMouseClickedLeft(int x, int y, bool down)
   {
      if(null == _Target) return;
      if(down)
      {
         _held = true;
         _holdPos = _Target.CanvasPosToLocal(new Point(x, y));
         InputHandler.MouseFocus = this;
      } else
      {
       _held=false;
        InputHandler.MouseFocus = null;
      }
   }
   
   void OnMouseMoved(int x, int y , int dx, int dy)
   {
     if(null == _Target) return;
     
     if(!_held) return;
     Point p = new Point(x - _holdPos.x, y-_holdPos.y);
     
     if(_Target.Parent != null)
     {
       p = _Target.Parent.CanvasPosToLocal(p);
     }
     
     _Target.MoveTo(p.x, p.y);
     Dragged.Invoke(this, GwenEventArgs.Empty);
   }
   
   void Render(GwenSkinBase skin)
   {
     
   }
  
  
   Dragger(GwenControlBase parent) : super(parent)
   {
     MouseInputEnabled = true;
     _held = true;
     _holdPos = new Point<int>(0, 0);
     _base = null;
   }
}