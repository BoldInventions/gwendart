part of gwendart;

class NumericUpDown extends TextBoxNumeric
{
  int Min;
  int Max;
  
  Splitter _splitter;
  UpDownButtonUp _up;
  UpDownButtonDown _down;
  
  
  
  NumericUpDown(GwenControlBase parent) : Min=0, Max=1000,  super(parent)
  {
    SetSize(100, 20);
    _value = 0.0;
    this.Text = "0";
    _splitter = new Splitter(this);
    _splitter.Dock = Pos.Right;
    _splitter.SetSize(13, 13);
    
    _up = new UpDownButtonUp(_splitter);
    _up.Clicked.add(new GwenControlEventHandler(OnButtonUp));
    _up.IsTabable=false;
    _splitter.SetPanel(0, _up);
    
    _down = new UpDownButtonDown(_splitter);
    _down.Clicked.add(new GwenControlEventHandler(OnButtonDown));
    _down.IsTabable=false;
    _splitter.SetPanel(1, _down);
    

  }
  
  GwenEventHandlerList ValueChanged = new GwenEventHandlerList();
  
  bool OnKeyDown(bool down)
  {
    if(down)
    {
      OnButtonDown(null, new ClickedEventArgs(0, 0, true));
    }
    return true;
  }
  
  void OnButtonUp(GwenControlBase control, GwenEventArgs args)
  {
    Value = _value + 1.0;
  }
  
  void OnButtonDown(GwenControlBase control, GwenEventArgs args)
  {
    Value = _value - 1.0;
  }
  
  bool IsTextAllowed2(String str)
  {
    if( (str=="") || (str=="-")) return true;
    bool bRet = super.IsTextAllowed2(str);
    if(bRet)
    {
      double d = double.parse(str);
      bRet = ( d >= Min ) && (d <= Max);
    }
    return bRet;
  }
  
  double get Value => super.Value;
  set Value (double d)
  {
    if(d < Min) d = Min.toDouble();
    if(d > Max) d = Max.toDouble();
    if(d==_value) return;
    super.Value = d;
  }
  
  
  
}