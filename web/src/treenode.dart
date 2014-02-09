part of gwendart;

class GwenTreeNodeEventHandler extends GwenEventHandler
{
   static const int SEL_CHANGED=0;
   static const int SELECTED=1;
   static const int UNSELECTED=2;
   static const int TOGGLE_PRESSED=3;
   static const int DBLCLICK_NAME=4;
   static const int CLICK_NAME=5;
   
   final TreeNode _treeNode;
   final int _code;
   GwenTreeNodeEventHandler(TreeNode treeNode, int code) : _treeNode=treeNode, _code=code
       {
     
       }
   
   void Invoke(GwenControlBase control, GwenEventArgs args)
   {
      switch(_code)
      {
        case SEL_CHANGED:
          _treeNode.SelectionChanged.Invoke(control, args);
          break;
        case SELECTED:
          _treeNode.Selected.Invoke(control, args);
          break;
        case UNSELECTED:
          _treeNode.Selected.Invoke(control, args);
          break;
        case TOGGLE_PRESSED:
          _treeNode.OnToggleButtonPress(control, args);
          break;
        case DBLCLICK_NAME:
          _treeNode.OnDoubleClickName(control, args);
          break;
        case CLICK_NAME:
          _treeNode.OnClickName(control, args);
          break;
        default:
          break;
      }
   }
}

class TreeNode extends GwenControlBase
{
  static const int TreeIndentation = 14;
  TreeControl _treeControl;
  Button _toggleButton;
  Button _title;
  bool _root;
  bool _selected;
  bool _selectable;
  
  bool get IsRoot => _root;
  set IsRoot (bool value) { _root=value; }
  
  TreeControl get MyTreeControl  => _treeControl;
  set MyTreeControl (TreeControl value)
  {
    _treeControl = value;
  }
  
  bool get IsSelectable => _selectable;
  set IsSelectable (bool value) { _selectable = value; }
  
  
  bool get IsSelected => _selected;
  set IsSelected (bool value)
  {
    if (!IsSelectable)
      return;
    if (IsSelected == value)
      return;

    _selected = value;

    if (_title != null)
      _title.ToggleState = value;


      SelectionChanged.Invoke(this, GwenEventArgs.Empty);

    // propagate to root parent (tree)
    if (_treeControl != null)
           _treeControl.SelectionChanged.Invoke(this, GwenEventArgs.Empty);

    if (value)
    {

       Selected.Invoke(this, GwenEventArgs.Empty);

      if (_treeControl != null)
         _treeControl.Selected.Invoke(this, GwenEventArgs.Empty);
    }
    else
    {
       Unselected.Invoke(this, GwenEventArgs.Empty);

      if (_treeControl != null && _treeControl.Unselected != null)
        _treeControl.Unselected.Invoke(this, GwenEventArgs.Empty);
    }
  }
  
  String get Text => _title.Text;
  set Text (String value)
  {
    _title.Text = value;
  }
  
  /// <summary>
  /// Invoked when the node label has been pressed.
  /// </summary>
GwenEventHandlerList LabelPressed= new GwenEventHandlerList();

  /// <summary>
  /// Invoked when the node's selected state has changed.
  /// </summary>
  GwenEventHandlerList SelectionChanged= new GwenEventHandlerList();

  /// <summary>
  /// Invoked when the node has been selected.
  /// </summary>
GwenEventHandlerList Selected= new GwenEventHandlerList();

  /// <summary>
  /// Invoked when the node has been unselected.
  /// </summary>
GwenEventHandlerList Unselected= new GwenEventHandlerList();

  /// <summary>
  /// Invoked when the node has been expanded.
  /// </summary>
GwenEventHandlerList Expanded= new GwenEventHandlerList();

  /// <summary>
  /// Invoked when the node has been collapsed.
  /// </summary>
GwenEventHandlerList Collapsed= new GwenEventHandlerList();
  
  
  TreeNode(GwenControlBase parent) : super(parent)
  {
    _toggleButton = new TreeToggleButton(this);
    _toggleButton.SetBounds(0, 0, 15, 15);
    _toggleButton.Toggled.add(new GwenTreeNodeEventHandler(this, GwenTreeNodeEventHandler.TOGGLE_PRESSED));
    
    _title = new TreeNodeLabel(this);
    _title.Dock = Pos.Top;
    _title.Margin = new GwenMargin(16, 0, 0, 0);
    _title.DoubleClicked.add(new GwenTreeNodeEventHandler(this, GwenTreeNodeEventHandler.DBLCLICK_NAME));
    _title.Clicked.add(new GwenTreeNodeEventHandler(this, GwenTreeNodeEventHandler.CLICK_NAME));
    
    m_InnerPanel = new GwenControlBase(this);
    m_InnerPanel.Dock = Pos.Top;
    m_InnerPanel.Height = 100;
    m_InnerPanel.Margin = new GwenMargin(TreeIndentation, 1, 0, 0);
    m_InnerPanel.Hide();
    
    _root = parent is TreeControl;
    _selected = false;
    _selectable = true;
    Dock = Pos.Top; 
  }
  

  /// <summary>
  /// Renders the control using specified skin.
  /// </summary>
  /// <param name="skin">Skin to use.</param>
  void Render(GwenSkinBase skin)
  {
    int bottom = 0;
    if (m_InnerPanel.Children.length > 0)
    {
      bottom = m_InnerPanel.Children.last.Y + m_InnerPanel.Y;
    }

    skin.DrawTreeNode(this, m_InnerPanel.IsVisible, IsSelected, _title.Height, _title.TextRight,
        (_toggleButton.Y + _toggleButton.Height * 0.5).toInt(), bottom, _treeControl == Parent); // IsRoot

    //[halfofastaple] HACK - The treenodes are taking two passes until their height is set correctly,
    //  this means that the height is being read incorrectly by the parent, causing
    //  the TreeNode bug where nodes get hidden when expanding and collapsing.
    //  The hack is to constantly invalide TreeNodes, which isn't bad, but there is
    //  definitely a better solution (possibly: Make it set the height from childmost
    //  first and work it's way up?) that invalidates and draws properly in 1 loop.
    this.Invalidate();
  }

  /// <summary>
  /// Lays out the control's interior according to alignment, padding, dock etc.
  /// </summary>
  /// <param name="skin">Skin to use.</param>
  void Layout(GwenSkinBase skin)
  {
    if (_toggleButton != null)
    {
      if (_title != null)
      {
        _toggleButton.SetPosition(0, ((_title.Height - _toggleButton.Height)*0.5).toInt());
      }

      if (m_InnerPanel.Children.length == 0)
      {
        _toggleButton.Hide();
        _toggleButton.ToggleState = false;
        m_InnerPanel.Hide();
      }
      else
      {
        _toggleButton.Show();
        m_InnerPanel.SizeToChildren(false, true);
      }
    }

    super.Layout(skin);
  }

  /// <summary>
  /// Function invoked after layout.
  /// </summary>
  /// <param name="skin">Skin to use.</param>
  void PostLayout(GwenSkinBase skin)
  {
    if (SizeToChildren(false, true))
    {
      InvalidateParent();
    }
  }

  /// <summary>
  /// Adds a new child node.
  /// </summary>
  /// <param name="label">Node's label.</param>
  /// <returns>Newly created control.</returns>
  TreeNode AddNode(String label)
  {
    TreeNode node = new TreeNode(this);
    node.Text = label;

    return node;
  }

  /// <summary>
  /// Opens the node.
  /// </summary>
  void Open()
  {
    m_InnerPanel.Show();
    if (_toggleButton != null)
      _toggleButton.ToggleState = true;

    if (Expanded != null)
      Expanded.Invoke(this, GwenEventArgs.Empty);
    if (_treeControl != null && _treeControl.Expanded != null)
      _treeControl.Expanded.Invoke(this, GwenEventArgs.Empty);

    Invalidate();
  }

  /// <summary>
  /// Closes the node.
  /// </summary>
  void Close()
  {
    m_InnerPanel.Hide();
    if (_toggleButton != null)
      _toggleButton.ToggleState = false;

    if (Collapsed != null)
      Collapsed.Invoke(this, GwenEventArgs.Empty);
    if (_treeControl != null && _treeControl.Collapsed != null)
      _treeControl.Collapsed.Invoke(this, GwenEventArgs.Empty);

    Invalidate();
  }

  /// <summary>
  /// Opens the node and all child nodes.
  /// </summary>
  void ExpandAll()
  {
    Open();
    for (GwenControlBase child in Children)
    {
      TreeNode node = child as TreeNode;
      if (node == null)
        continue;
      node.ExpandAll();
    }
  }

  /// <summary>
  /// Clears the selection on the node and all child nodes.
  /// </summary>
  void UnselectAll()
  {
    IsSelected = false;
    if (_title != null)
      _title.ToggleState = false;

    for (GwenControlBase child in Children)
    {
      TreeNode node = child as TreeNode;
      if (node == null)
        continue;
      node.UnselectAll();
    }
  }

  /// <summary>
  /// Handler for the toggle button.
  /// </summary>
  /// <param name="control">Event source.</param>
  void OnToggleButtonPress(GwenControlBase control, GwenEventArgs args)
  {
    if (_toggleButton.ToggleState)
    {
      Open();
    }
    else
    {
      Close();
    }
  }

  /// <summary>
  /// Handler for label double click.
  /// </summary>
  /// <param name="control">Event source.</param>
  void OnDoubleClickName(GwenControlBase control, GwenEventArgs args)
  {
    if (!_toggleButton.IsVisible)
      return;
    _toggleButton.Toggle();
  }

  /// <summary>
  /// Handler for label click.
  /// </summary>
  /// <param name="control">Event source.</param>
  void OnClickName(GwenControlBase control, GwenEventArgs args)
  {
    if (LabelPressed != null)
      LabelPressed.Invoke(this, GwenEventArgs.Empty);
    IsSelected = !IsSelected;
  }

  void SetImage(String textureName) 
  {
    _title.SetImage(textureName);
  }

  void OnChildAdded(GwenControlBase child) {
    TreeNode node;  
    if (node != null) {
      if(child is TreeNode)
      {
      node = child;
      node.MyTreeControl = _treeControl;

      if (_treeControl != null) {
        _treeControl.OnNodeAdded(node);
      }
      }
    }

    super.OnChildAdded(child);
  }
  
  /* TODO: Implement handlers for clicking on title */
/*
  GwenEventHandlerList Clicked
  { 
    add {
      _title.Clicked += delegate(GwenControlBase sender, ClickedEventArgs args) { value(this, args); };
    }
    remove {
      _title.Clicked -= delegate(GwenControlBase sender, ClickedEventArgs args) { value(this, args); };
    }
  }

  GwenEventHandlerList DoubleClicked 
  { 
    add {
      if (value != null) {
        _title.DoubleClicked += delegate(GwenControlBase sender, ClickedEventArgs args) { value(this, args); };
      }
    }
    remove {
      _title.DoubleClicked -= delegate(GwenControlBase sender, ClickedEventArgs args) { value(this, args); };
    }
  }

  GwenEventHandlerList RightClicked {
    add {
      _title.RightClicked += delegate(GwenControlBase sender, ClickedEventArgs args) { value(this, args); };
    }
    remove {
      _title.RightClicked -= delegate(GwenControlBase sender, ClickedEventArgs args) { value(this, args); };
    }
  }

  GwenEventHandlerList DoubleRightClicked {
    add {
      if (value != null) {
        _title.DoubleRightClicked += delegate(GwenControlBase sender, ClickedEventArgs args) { value(this, args); };
      }
    }
    remove {
      _title.DoubleRightClicked -= delegate(GwenControlBase sender, ClickedEventArgs args) { value(this, args); };
    }
  }
  */
  
  
}