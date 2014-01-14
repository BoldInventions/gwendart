part of gwendart;

class Splitter extends GwenControlBase
{
  List<GwenControlBase> _panels;
  List<bool> _bScales;
  
  Splitter(GwenControlBase parent) : super(parent)
  {
    _panels = new List<GwenControlBase>(2);
    _bScales = new List<bool>(2);
    _bScales[0]=true;
    _bScales[1]=true;
  }
  
  void SetPanel(int panelIndex, GwenControlBase panel, [bool noScale = false])
  {
    if( panelIndex < 0 || panelIndex > 1)
    {
      throw new ArgumentError("Invalid panel index");
    }
    
    _panels[panelIndex]=panel;
    _bScales[panelIndex]= !noScale;
    if(null != _panels[panelIndex])
    {
      _panels[panelIndex].Parent = this;
    }
  }
  
  GwenControlBase GetPanel(int panelIndex)
  {
    if( panelIndex < 0 || panelIndex > 1)
    {
      throw new ArgumentError("Invalid panel index");
    }
    return _panels[panelIndex];
  }
  
  void Layout(GwenSkinBase skin)
  {
    LayoutVertical(skin);
  }
  
  
  void LayoutVertical(GwenSkinBase skin)
  {
    int w = Width;
    int h = Height;
    
    if( _panels[0] != null)
    {
      GwenMargin m = _panels[0].Margin;
      if(_bScales[0])
      {
        _panels[0].SetBounds(m.Left, m.Top, w-m.Left-m.Right, h ~/ 2 - m.Top - m.Bottom);
      } else
      {
        _panels[0].Position(Pos.Center, 0, h ~/ 4);
      }
    }
    if( _panels[1] != null)
    {
      GwenMargin m = _panels[1].Margin;
      if(_bScales[1])
      {
        _panels[1].SetBounds(m.Left, m.Top+(h ~/ 2), w-m.Left-m.Right, h ~/ 2 - m.Top - m.Bottom);
      } else
      {
        _panels[1].Position(Pos.Center, 0, h ~/ 4);
      }
    }
  }
  
  void LayoutHorizontal(GwenSkinBase skin)
  {
    throw new UnimplementedError("splitter.LayoutHorizontal() not implemented yet.");
  }
  
}















