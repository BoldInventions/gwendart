part of gwendart;

class Modal extends GwenControlBase
{
   
   Modal(GwenControlBase parent) : super(parent)
   {
      KeyboardInputEnabled = true;
      MouseInputEnabled = true;
      ShouldDrawBackground = true;
      SetBounds(0, 0, GetCanvas().Width, GetCanvas().Height);
   }
   
   void Layout(GwenSkinBase skin)
   {
     SetBounds(0, 0, GetCanvas().Width, GetCanvas().Height);
   }
   
   void Render(GwenSkinBase skin)
   {
     skin.DrawModalControl(this);
   }
   
   
}