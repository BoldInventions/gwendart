part of gwendart;

class ScrollBarBar extends Dragger
{
   bool _horizontal;
   bool get IsHorizontal => _horizontal;
   set IsHorizontal (bool value) { _horizontal = value; }
   
   bool get IsVertical => !_horizontal;
   set IsVertical (bool value) { _horizontal = !value; }
   
   ScrollBarBar(GwenControlBase parent) : super(parent)
   {
     RestrictToParent = true;
     _Target = this;
   }
   
   void Render(GwenSkinBase skin)
   {
     skin.DrawScrollBarBar(this, _held, IsHovered, _horizontal);
   }
   
   void OnMouseMoved(int x, int y, int dx, int dy)
   {
      super.OnMouseMoved(x, y, dx, dy);
      if(!_held) return;
      InvalidateParent();
   }
}