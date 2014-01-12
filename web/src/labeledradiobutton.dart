part of gwendart;
class GwenRBPressEventHandler extends GwenEventHandler
{
  final RadioButton _checkbox;
  GwenRBPressEventHandler(RadioButton checkbox) : _checkbox = checkbox
  {
    
  }
  
  void Invoke(GwenControlBase control, GwenEventArgs args)
  {
    _checkbox.Press(control);
  }
}
class LabeledRadioButton extends GwenControlBase
{
   RadioButton _radioButton;
   Label _label;
   
   String get Text => _label.Text;
   set Text (String value) 
   {
      _label.Text = value;
   }
   
   LabeledRadioButton(GwenControlBase parent) : super(parent)
   {
     MouseInputEnabled = true;
     SetSize(100, 20);
     
     _radioButton = new RadioButton(this);
     _radioButton.IsTabable = false;
     _radioButton.KeyboardInputEnabled=false;
     
     _label = new Label(this);
     _label.Alignment = new Pos(Pos.CenterV.value | Pos.Left.value);
     _label.Text = "Radio Button";
     _label.Clicked.add(new GwenRBPressEventHandler(_radioButton));
     _label.IsTabable = false;
     _label.KeyboardInputEnabled = false;
     _label.AutoSizeToContents = false;
   }
   
   void Layout(GwenSkinBase skin)
   {
     if(_label.Height > _radioButton.Height)
     {
       _radioButton.Y = (_label.Height - _radioButton.Height)~/2; 
     }
     Align.PlaceRightBottom(_label, _radioButton);
     SizeToChildren();
     super.Layout(skin);
   }
   
   void RenderFocus(GwenSkinBase skin)
   {
      if(InputHandler.KeyboardFocus != this) return;
      if(!IsTabable) return;
      skin.DrawKeyboardHighlight(this, RenderBounds, 0);
   }
   
   RadioButton get _RadioButton => _radioButton;
   
   bool OnKeySpace(bool down)
   {
     if(down)
     {
       _radioButton.IsChecked = !_radioButton.IsChecked;
     }
     return true;
   }
   
   void Select()
   {
      _radioButton.IsChecked = true;
   }
   
}


