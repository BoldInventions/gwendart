part of gwendart;

class CloseButton extends Button
{
  
   final WindowControl _window;
  
   CloseButton(GwenControlBase parent, WindowControl owner) : _window=owner,  super(parent)
   {
     
   }
   
   void Render(GwenSkinBase skin)
   {
     skin.DrawWindowCloseButton(this, IsDepressed && IsHovered, IsHovered && ShouldDrawHover, !_window.IsOnTop);
   }
}