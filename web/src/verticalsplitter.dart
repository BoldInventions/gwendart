part of gwendart;

class VerticalSplitter extends GwenControlBase
{
  
  SplitterBar _hSplitter;
  List<GwenControlBase> _sections;
  
  double _hVal;
  int _barSize;
  int _zoomedSection;
  
  GwenEventHandlerList PanelZoomed = new GwenEventHandlerList();
  GwenEventHandlerList PanelUnZoomed = new GwenEventHandlerList();
  GwenEventHandlerList ZoomChanged = new GwenEventHandlerList();
  
  VerticalSplitter(GwenControlBase parent) : super(parent)
  {
    _sections = new List<GwenControlBase>(2);
    
    
    _hSplitter = new SplitterBar(this);
    _hSplitter.SetPosition(128, 0);
    _hSplitter.Dragged.add(new GwenControlEventHandler(OnHorizontalMoved));
    _hSplitter.Cursor = CssCursor.SizeWE;

    _hVal = 0.5;

    
    SetPanel(0, null);
    SetPanel(1, null);

    SplitterSize = 5;
    SplittersVisible = false;
    
    _zoomedSection = -1;
  }

  void CenterPanels()
  {
    _hVal = 0.5;
    Invalidate();
  }
  
  
  bool get IsZoomed => _zoomedSection != -1;
  
  bool get SplittersVisible => _hSplitter.ShouldDrawBackground;
  set SplittersVisible(bool value)
  {

    _hSplitter.ShouldDrawBackground=value;
  }
  
  int get SplitterSize => _barSize;
  set SplitterSize (int value)
  {
    _barSize = value;
  }
  
  void SetHValue(double value) { if( (value <= 1.0) && (value >=0.0) ) { _hVal = value; } }
  

  
  void UpdateHSplitter()
  {
    _hSplitter.MoveTo( ( (Width-_hSplitter.Width) * _hVal).toInt(), _hSplitter.Y);
  }
  


  void OnHorizontalMoved(GwenControlBase control, GwenEventArgs args)
  {
    _hVal = CalculateValueHorizontal();
    Invalidate();
  }



  double CalculateValueHorizontal()
  {
    return _hSplitter.X / (Width - _hSplitter.Width);
  }

  /// <summary>
  /// Lays out the control's interior according to alignment, padding, dock etc.
  /// </summary>
  /// <param name="skin">Skin to use.</param>
  void Layout(GwenSkinBase skin)
  {

    _hSplitter.SetSize(_barSize, Height);

    UpdateHSplitter();


    if (_zoomedSection == -1)
    {
      if (_sections[0] != null)
        _sections[0].SetBounds(0, 0, _hSplitter.X, Height);

      if (_sections[1] != null)
        _sections[1].SetBounds(_hSplitter.X + _barSize, 0, Width - (_hSplitter.X + _barSize), Height);

    }
    else
    {
      //This should probably use Fill docking instead
      _sections[_zoomedSection].SetBounds(0, 0, Width, Height);
    }
  }

  /// <summary>
  /// Assigns a control to the specific inner section.
  /// </summary>
  /// <param name="index">Section index (0-3).</param>
  /// <param name="panel">Control to assign.</param>
  void SetPanel(int index, GwenControlBase panel)
  {
    _sections[index] = panel;

    if (panel != null)
    {
      panel.Dock = Pos.None;
      panel.Parent = this;
    }

    Invalidate();
  }

  /// <summary>
  /// Gets the specific inner section.
  /// </summary>
  /// <param name="index">Section index (0-3).</param>
  /// <returns>Specified section.</returns>
  GwenControlBase GetPanel(int index)
  {
    return _sections[index];
  }

  /// <summary>
  /// Internal handler for the zoom changed event.
  /// </summary>
  void OnZoomChanged()
  {
    if (ZoomChanged != null)
      ZoomChanged.Invoke(this, GwenEventArgs.Empty);
    
    if (_zoomedSection == -1)
    {
      if (PanelUnZoomed != null)
        PanelUnZoomed.Invoke(this, GwenEventArgs.Empty);
    }
    else
    {
      if (PanelZoomed != null)
        PanelZoomed.Invoke(this, GwenEventArgs.Empty);
    }
  }

  /// <summary>
  /// Maximizes the specified panel so it fills the entire control.
  /// </summary>
  /// <param name="section">Panel index (0-3).</param>
  void Zoom(int section)
  {
    UnZoom();

    if (_sections[section] != null)
    {
      for (int i = 0; i < 4; i++)
      {
        if (i != section && _sections[i] != null)
          _sections[i].IsHidden = true;
      }
      _zoomedSection = section;

      Invalidate();
    }
    OnZoomChanged();
  }

  /// <summary>
  /// Restores the control so all panels are visible.
  /// </summary>
  void UnZoom()
  {
    _zoomedSection = -1;

    for (int i = 0; i < 4; i++)
    {
      if (_sections[i] != null)
        _sections[i].IsHidden = false;
    }

    Invalidate();
    OnZoomChanged();
  }
  
}