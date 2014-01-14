part of gwendart;

class RightArrow extends GwenControlBase
{
   RightArrow(GwenControlBase parent) : super(parent)
   {
     MouseInputEnabled = false;
   }
   
   void Render(GwenSkinBase skin)
   {
     skin.DrawMenuRightArrow(this);
   }
}