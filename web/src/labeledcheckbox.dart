part of gwendart;

class GwenPressEventHandler extends GwenEventHandler
{
  final CheckBox _checkbox;
  GwenPressEventHandler(CheckBox checkbox) : _checkbox = checkbox
  {
    
  }
  
  void Invoke(GwenControlBase control, GwenEventArgs args)
  {
    _checkbox.Press(control);
  }
}


class GwenCheckBoxChangedEventHandler extends GwenEventHandler
{
  final LabeledCheckBox _checkbox;
  GwenCheckBoxChangedEventHandler(LabeledCheckBox checkbox) : _checkbox = checkbox
  {
    
  }
  
  void Invoke(GwenControlBase control, GwenEventArgs args)
  {
    _checkbox.OnCheckChanged(control, args);
  }
}

class LabeledCheckBox extends GwenControlBase
{
   CheckBox _checkBox;
   Label _label;
   
   GwenEventHandlerList Checked = new GwenEventHandlerList();
   GwenEventHandlerList UnChecked = new GwenEventHandlerList();
   GwenEventHandlerList CheckChanged = new GwenEventHandlerList();
   
   bool get IsChecked => _checkBox.IsChecked;
   set IsChecked(bool value) { _checkBox.IsChecked = value; }
   
   String get Text => _label.Text;
   set Text (String value ) { _label.Text = value; }
   

   LabeledCheckBox(GwenControlBase parent) : super(parent)
   {
      SetSize(200, 19);
      _checkBox = new CheckBox(this);
      _checkBox.Dock = Pos.Left;
      _checkBox.Margin = new GwenMargin(0, 2, 2, 2);
      _checkBox.IsTabable = false;
      _checkBox.CheckChanged.add(new GwenCheckBoxChangedEventHandler(this));
      
      _label = new Label(this);
      _label.Dock = Pos.Fill;
      _label.Clicked.add(new GwenPressEventHandler(_checkBox));
      _label.IsTabable=false;
      _label.AutoSizeToContents =false;
   }
   
   void OnCheckChanged(GwenControlBase control, GwenEventArgs args)
   {
      if(_checkBox.IsChecked)
      {
        Checked.Invoke(this, GwenEventArgs.Empty);
      } else
      {
        UnChecked.Invoke(this, GwenEventArgs.Empty);
      }
      CheckChanged.Invoke(this, GwenEventArgs.Empty);
   }
   
   bool OnKeySpace(bool down)
   {
     super.OnKeySpace(down);
     if(!down)
     {
       _checkBox.IsChecked = !_checkBox.IsChecked;
     }
   }
}