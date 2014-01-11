part of gwendart;

class CheckBox extends Button
{
    bool _checked=false;
    
    bool get IsChecked  => _checked;
    set IsChecked(bool value) 
    {
       if(value == _checked) return;
       _checked = value;
       OnCheckChanged();
    }
    
    CheckBox(GwenControlBase parent) : super(parent)
    {
       SetSize(15, 15);
       IsToggle=true;
    }
    
    void Toggle()
    {
      super.Toggle();
      IsChecked = !IsChecked;
    }
    
    GwenEventHandlerList Checked = new GwenEventHandlerList();
    GwenEventHandlerList UnChecked = new GwenEventHandlerList();
    GwenEventHandlerList CheckChanged = new GwenEventHandlerList();
    
    bool get AllowUncheck => true;
    
    void OnCheckChanged()
    {
      if(IsChecked)
      {
       if(Checked != null)
       {
          Checked.Invoke(this, GwenEventArgs.Empty);
       }
      } else
      {
         if(null!=UnChecked) UnChecked.Invoke(this, GwenEventArgs.Empty);
      }
      if(null != CheckChanged)
      {
        CheckChanged.Invoke(this, GwenEventArgs.Empty);
      }
    }
    
    void Render(GwenSkinBase skin)
    {
       super.Render(skin);
       skin.DrawCheckBox(this, _checked, IsDepressed);
    }
    
    void OnClicked(int x, int y)
    {
      if(IsDisabled) return;
      if(IsChecked && !AllowUncheck)
      {
        return;
      }
      super.OnClicked(x, y);
    }
    
}