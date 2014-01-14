part of gwendart;

class HorizontalSplitter extends GwenControlBase
{
  
  SplitterBar _vSplitter;

  
  List<GwenControlBase> _sections;
  
  double _vVal; // 0-1
  int _barSize; // pixels
  
  int _zoomedSection; // 0-3
  
  GwenEventHandlerList PanelZoomed = new GwenEventHandlerList();
  GwenEventHandlerList PanelUnZoomed = new GwenEventHandlerList();
  GwenEventHandlerList ZoomChanged = new GwenEventHandlerList();
  
  HorizontalSplitter(GwenControlBase parent) : super(parent)
  {
    _sections = new List<GwenControlBase>(2);
    
    _vSplitter = new SplitterBar(this);
    _vSplitter.SetPosition(0, 128);
    _vSplitter.Dragged.add(new GwenControlEventHandler(OnVerticalMoved));
    _vSplitter.Cursor = CssCursor.SizeNS;
    

    

    _vVal = 0.5;
    
    SetPanel(0, null);
    SetPanel(1, null);

    
    SplitterSize = 5;
    SplittersVisible = false;
    
    _zoomedSection = -1;
  }
  
  void CenterPanels()
  {
    _vVal = 0.5;
    Invalidate();
  }
  
  
  bool get IsZoomed => _zoomedSection != -1;
  
  bool get SplittersVisible => _vSplitter.ShouldDrawBackground;
  set SplittersVisible(bool value)
  {
    _vSplitter.ShouldDrawBackground=value;
  }
  
  int get SplitterSize => _barSize;
  set SplitterSize (int value)
  {
    _barSize = value;
  }
  
  void UpdateVSplitter()
  {
    _vSplitter.MoveTo(_vSplitter.X, ((Height-_vSplitter.Height) * _vVal).toInt());
  }
  

  


  void OnVerticalMoved(GwenControlBase control, GwenEventArgs args)
  {
    _vVal = CalculateValueVertical();
    Invalidate();
  }



  double CalculateValueVertical()
  {
    return _vSplitter.Y / (Height - _vSplitter.Height);
  }



  /// <summary>
  /// Lays out the control's interior according to alignment, padding, dock etc.
  /// </summary>
  /// <param name="skin">Skin to use.</param>
  void Layout(GwenSkinBase skin)
  {
    _vSplitter.SetSize(Width, _barSize);


    UpdateVSplitter();


    if (_zoomedSection == -1)
    {
      if (_sections[0] != null)
        _sections[0].SetBounds(0, 0, Width, _vSplitter.Y);

      if (_sections[1] != null)
        _sections[1].SetBounds(0, _vSplitter.Y + _barSize, Width, Height - (_vSplitter.Y + _barSize));

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


