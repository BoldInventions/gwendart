part of gwendart;


class GwenCrossSplitterEventHandler extends GwenEventHandler
{
  static const VERTICAL_MOVED=0;
  static const HORIZ_MOVED=1;
  static const CENTER_MOVED=2;
  
  final CrossSplitter _crossSplitter;
  final int _code;
  
  GwenCrossSplitterEventHandler(CrossSplitter crossSplitter, int code) : _crossSplitter=crossSplitter, _code=code
      {
    
      }
  
  void Invoke(GwenControlBase control, GwenEventArgs args)
  {
    switch(_code)
    {
      case VERTICAL_MOVED:
        _crossSplitter.OnVerticalMoved(control, args);
        break;
      case HORIZ_MOVED:
        _crossSplitter.OnHorizontalMoved(control, args);
        break;
      case CENTER_MOVED:
        _crossSplitter.OnCenterMoved(control, args);
        break;
      default:
        break;
    }
  }
  
}

class CrossSplitter extends GwenControlBase
{
  
  SplitterBar _vSplitter;
  SplitterBar _hSplitter;
  SplitterBar _cSplitter;
  
  List<GwenControlBase> _sections;
  
  double _hVal; // 0-1
  double _vVal; // 0-1
  int _barSize; // pixels
  
  int _zoomedSection; // 0-3
  
  GwenEventHandlerList PanelZoomed = new GwenEventHandlerList();
  GwenEventHandlerList PanelUnZoomed = new GwenEventHandlerList();
  GwenEventHandlerList ZoomChanged = new GwenEventHandlerList();
  
  CrossSplitter(GwenControlBase parent) : super(parent)
  {
    _sections = new List<GwenControlBase>(4);
    
    _vSplitter = new SplitterBar(this);
    _vSplitter.SetPosition(0, 128);
    _vSplitter.Dragged.add(new GwenCrossSplitterEventHandler(this, GwenCrossSplitterEventHandler.VERTICAL_MOVED));
    _vSplitter.Cursor = CssCursor.SizeNS;
    
    _hSplitter = new SplitterBar(this);
    _hSplitter.SetPosition(128, 0);
    _hSplitter.Dragged.add(new GwenCrossSplitterEventHandler(this, GwenCrossSplitterEventHandler.HORIZ_MOVED));
    _hSplitter.Cursor = CssCursor.SizeWE;

    _cSplitter = new SplitterBar(this);
    _cSplitter.SetPosition(128, 128);
    _cSplitter.Dragged.add(new GwenCrossSplitterEventHandler(this, GwenCrossSplitterEventHandler.CENTER_MOVED));
    _cSplitter.Cursor = CssCursor.SizeAll;
    
    _hVal = 0.5;
    _vVal = 0.5;
    
    SetPanel(0, null);
    SetPanel(1, null);
    SetPanel(2, null);
    SetPanel(3, null);
    
    SplitterSize = 5;
    SplittersVisible = false;
    
    _zoomedSection = -1;
  }
  
  void CenterPanels()
  {
    _hVal = 0.5;
    _vVal = 0.5;
    Invalidate();
  }
  
  
  bool get IsZoomed => _zoomedSection != -1;
  
  bool get SplittersVisible => _cSplitter.ShouldDrawBackground;
  set SplittersVisible(bool value)
  {
    _cSplitter.ShouldDrawBackground=value;
    _vSplitter.ShouldDrawBackground=value;
    _hSplitter.ShouldDrawBackground=value;
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
  
  void UpdateHSplitter()
  {
    _hSplitter.MoveTo( ((Width-_hSplitter.Width) * _hVal).toInt(), _hSplitter.Y);
  }
  
  void UpdateCSplitter()
  {
    _cSplitter.MoveTo( ((Width-_hSplitter.Width) * _hVal).toInt(), ((Height-_vSplitter.Height) * _vVal).toInt());
  }
  

  void OnCenterMoved(GwenControlBase control, GwenEventArgs args)
  {
    CalculateValueCenter();
    Invalidate();
  }

  void OnVerticalMoved(GwenControlBase control, GwenEventArgs args)
  {
    _vVal = CalculateValueVertical();
    Invalidate();
  }

  void OnHorizontalMoved(GwenControlBase control, GwenEventArgs args)
  {
    _hVal = CalculateValueHorizontal();
    Invalidate();
  }

  void CalculateValueCenter()
  {
    _hVal = _cSplitter.X / (Width - _cSplitter.Width);
    _vVal = _cSplitter.Y / (Height - _cSplitter.Height);
  }

  double CalculateValueVertical()
  {
    return _vSplitter.Y / (Height - _vSplitter.Height);
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
    _vSplitter.SetSize(Width, _barSize);
    _hSplitter.SetSize(_barSize, Height);
    _cSplitter.SetSize(_barSize, _barSize);

    UpdateVSplitter();
    UpdateHSplitter();
    UpdateCSplitter();

    if (_zoomedSection == -1)
    {
      if (_sections[0] != null)
        _sections[0].SetBounds(0, 0, _hSplitter.X, _vSplitter.Y);

      if (_sections[1] != null)
        _sections[1].SetBounds(_hSplitter.X + _barSize, 0, Width - (_hSplitter.X + _barSize), _vSplitter.Y);

      if (_sections[2] != null)
        _sections[2].SetBounds(0, _vSplitter.Y + _barSize, _hSplitter.X, Height - (_vSplitter.Y + _barSize));

      if (_sections[3] != null)
        _sections[3].SetBounds(_hSplitter.X + _barSize, _vSplitter.Y + _barSize, Width - (_hSplitter.X + _barSize), Height - (_vSplitter.Y + _barSize));
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