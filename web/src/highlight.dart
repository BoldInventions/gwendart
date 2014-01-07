part of gwendart;

class Highlight extends GwenControlBase
{
   Highlight(GwenControlBase parent) : super(parent)
   {
     
   }
   
   void Render(GwenSkinBase skin)
   {
     skin.DrawHighlight(this);
   }
}