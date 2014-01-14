part of gwendart;


class GwenTreeControlEventHandler extends GwenEventHandler
{
  final TreeControl _treeControl;
  GwenTreeControlEventHandler(TreeControl treeControl) : _treeControl = treeControl
      {
    
      }
  
  void Invoke(GwenControlBase control, GwenEventArgs args)
  {
     _treeControl.OnNodeSelected(control, args);
  }
}

class TreeControl extends TreeNode
{
  
  ScrollControl _scrollControl;
  bool _multiSelect;
  
  bool get AllowMultiSelect => _multiSelect;
  set AllowMultiSelect(bool value) { _multiSelect = value; }
  
  
  TreeControl(GwenControlBase parent) : super(parent)
  {
    _treeControl = this;
    
    RemoveChild(_toggleButton, true);
    _toggleButton = null;
    RemoveChild(_title, true);
    _title = null;
    RemoveChild(m_InnerPanel, true);
    m_InnerPanel=null;
    
    _multiSelect = false;
    
    _scrollControl = new ScrollControl(this);
    _scrollControl.Dock = Pos.Fill;
    _scrollControl.EnableScroll(false, true);
    _scrollControl.AutoHideBars=true;
    _scrollControl.Margin = GwenMargin.One;
    
    m_InnerPanel = _scrollControl;
    _scrollControl.SetInnerSize(1000, 1000); // TODO: figure out why these arbitraty numbers are here.
    
    Dock = Pos.None;
  }
  
  void Render(GwenSkinBase skin)
  {
    if(ShouldDrawBackground)
    {
      skin.DrawTreeControl(this);
    }
  }
  
  void OnChildBoundsChanged(Rectangle oldChildBounds, GwenControlBase child)
  {
    if(_scrollControl != null)
    {
      _scrollControl.UpdateScrollBars();
    }
  }
  
  
  void RemoveAll()
  {
    _scrollControl.DeleteAll();
  }
  
  OnNodeAdded(TreeNode node)
  {
    node.LabelPressed.add(new GwenTreeControlEventHandler(this)); 
  }
  
  void OnNodeSelected(GwenControlBase control, GwenEventArgs args)
  {
    if(_multiSelect)
    {
      UnselectAll();
    }
  }
  
  
}