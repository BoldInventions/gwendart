part of gwendart;
class TabControlInner extends GwenControlBase
{
  
   TabControlInner._internal(GwenControlBase parent) : super(parent)
   {
     
   }
   
   void Render(GwenSkinBase skin)
   {
     skin.DrawTabControl(this);
   }
  
}