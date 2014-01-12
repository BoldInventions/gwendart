part of gwendart;

class GwenRadioButtonGroupClickEventHandler extends GwenEventHandler
{
  final RadioButtonGroup _checkbox;
  GwenRadioButtonGroupClickEventHandler(RadioButtonGroup checkbox) : _checkbox = checkbox
  {
    
  }
  
  void Invoke(GwenControlBase control, GwenEventArgs args)
  {
    _checkbox.OnRadioClicked(control, args);
  }
}

class RadioButtonGroup extends GroupBox
{
   LabeledRadioButton _selected;
   
   LabeledRadioButton get Selected => _selected;
   
   String get SelectedName => _selected.Name;
   
   String get SelectedLabel => _selected.Text;
   
   int get SelectedIndex => Children.indexOf(_selected);
   
   GwenEventHandlerList SelectionChanged = new GwenEventHandlerList();
   
   RadioButtonGroup(GwenControlBase parent) : super(parent)
   {
     AutoSizeToContents = true;
     IsTabable = false;
     KeyboardInputEnabled = true;
     super.Text = "";
   }
   
   LabeledRadioButton AddOption(String text, [String optionName])
   {
      LabeledRadioButton lrb = new LabeledRadioButton(this);
      lrb.Name = optionName;
      lrb.Text = text;
      lrb._RadioButton.Checked.add(new GwenRadioButtonGroupClickEventHandler(this));
      lrb.Dock = Pos.Top;
      lrb.Margin = new GwenMargin(0, 0, 0, 1);
      lrb.KeyboardInputEnabled = false;
      lrb.IsTabable = true;
      Invalidate();
      return lrb;
   }
   
   void OnRadioClicked(GwenControlBase control, GwenEventArgs args)
   {
      if(control is RadioButton)
      {
        RadioButton radioButton = control;
        for(GwenControlBase ctrl in Children)
        {
           if(ctrl is LabeledRadioButton)
           {
             LabeledRadioButton lrb = ctrl;
             if(lrb._RadioButton == radioButton)
             {
               _selected = lrb;
             } else
             {
               lrb._RadioButton.IsChecked = false;
             }
           }
        }
        OnChanged(_selected);
      }
   }
   
   
   
   void OnChanged(GwenControlBase newTarget)
   {
     SelectionChanged.Invoke(this, new ItemSelectedEventArgs(newTarget));
   }
   
   void SetSelection(int index)
   {
     if( (index < 0) || (index >= Children.length))
     {
       return;
     }
     if(Children[index] is LabeledRadioButton)
     {
       LabeledRadioButton lrb = Children[index];
       lrb._RadioButton.Press();
     }
   }
   
}