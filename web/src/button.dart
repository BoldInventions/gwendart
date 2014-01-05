part of gwendart;

class Button extends Label
{
  
   bool _depressed;
   bool IsToggle;
   bool _toggleStatus;
   bool _centerImage;
   ImagePanel _image;
   
   GwenEventHandlerList Pressed = new GwenEventHandlerList();
   GwenEventHandlerList Released = new GwenEventHandlerList();
   GwenEventHandlerList Toggled = new GwenEventHandlerList();
   GwenEventHandlerList ToggledOn = new GwenEventHandlerList();
   GwenEventHandlerList ToggledOff = new GwenEventHandlerList();
  
  
   bool get IsDepressed => _depressed;
   set IsDepressed(bool value)
   {
     if(_depressed == value) return;
     _depressed = value;
     Redraw();
   }
   
   bool get ToggleState => _toggleStatus;
   set ToggleState(bool value)
   {
     if(!IsToggle) return;
     if(_toggleStatus == value) return;
     _toggleStatus = value;
     Toggled.Invoke(this, GwenEventArgs.Empty);
     if(_toggleStatus)
     {
       ToggledOn.Invoke(this, GwenEventArgs.Empty);
     } else
     {
       ToggledOff.Invoke(this, GwenEventArgs.Empty);
     }
     Redraw();
   }
   
   
   Button(GwenControlBase parent) : super(parent)
   {
     AutoSizeToContents=false;
     SetSize(100, 20);
     MouseInputEnabled=true;
     Alignment = Pos.Center;
     _depressed = false;
     IsToggle=false;
     _toggleStatus=false;
     _centerImage=false;
     _image=null;
   }
}