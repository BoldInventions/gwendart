part of gwendart;

class DockBaseEventHandler extends GwenEventHandler
{
   final DockBase _dockBase;
   
   DockBaseEventHandler(DockBase dockBase) : _dockBase = dockBase
   {
     
   }
   
   void Invoke(GwenControlBase control, GwenEventArgs args)
   {
      _dockBase.OnTabRemoved(control, args);
   }
}

class DockBase extends GwenControlBase
{
   DockBase _left;
   DockBase _right;
   DockBase _top;
   DockBase _bottom;
   Resizer _sizer;
   DockedTabControl _dockedTabControl;
   
   bool _drawHover;
   bool _dropFar;
   Rectangle _hoverRect;
   
   DockBase get LeftDock => GetChildDock(Pos.Left);
   DockBase get TopDock => GetChildDock(Pos.Top);
   DockBase get RightDock => GetChildDock(Pos.Right);
   DockBase get BottomDock => GetChildDock(Pos.Bottom);
   
   TabControl get MyDockedTabControl => _dockedTabControl;
   
   DockBaseEventHandler _dockBaseEventHandler;
  
   DockBase(GwenControlBase parent) : super(parent)
   {
     Padding = GwenPadding.One;
     SetSize(200, 200);
     _dockBaseEventHandler = new DockBaseEventHandler(this);
   }
   

   /// <summary>
   /// Handler for Space keyboard event.
   /// </summary>
   /// <param name="down">Indicates whether the key was pressed or released.</param>
   /// <returns>
   /// True if handled.
   /// </returns>
   bool OnKeySpace(bool down)
   {
     // No action on space (default button action is to press)
     return false;
   }

   /// <summary>
   /// Initializes an inner docked control for the specified position.
   /// </summary>
   /// <param name="pos">Dock position.</param>
   void SetupChildDock(Pos pos)
   {
     if (_dockedTabControl == null)
     {
       _dockedTabControl = new DockedTabControl(this);
       _dockedTabControl.TabRemoved.add(_dockBaseEventHandler);
       _dockedTabControl.TabStripPosition = Pos.Bottom;
       _dockedTabControl.TitleBarVisible = true;
     }

     Dock = pos;

     Pos sizeDir;
     if (pos == Pos.Right) sizeDir = Pos.Left;
     else if (pos == Pos.Left) sizeDir = Pos.Right;
     else if (pos == Pos.Top) sizeDir = Pos.Bottom;
     else if (pos == Pos.Bottom) sizeDir = Pos.Top;
     else throw new ArgumentError("Invalid dock pos");

     if (_sizer != null)
       _sizer.Dispose();
     _sizer = new Resizer(this);
     _sizer.Dock = sizeDir;
     _sizer.ResizeDir = sizeDir;
     _sizer.SetSize(2, 2);
   }

   /// <summary>
   /// Renders the control using specified skin.
   /// </summary>
   /// <param name="skin">Skin to use.</param>
   void Render(GwenSkinBase skin)
   {

   }

   /// <summary>
   /// Gets an inner docked control for the specified position.
   /// </summary>
   /// <param name="pos"></param>
   /// <returns></returns>
   DockBase GetChildDock(Pos pos)
   {
     // todo: verify
     DockBase dock = null;
     switch (pos)
     {
       case Pos.Left:
         if (_left == null)
         {
           _left = new DockBase(this);
           _left.SetupChildDock(pos);
         }
         dock = _left;
         break;

       case Pos.Right:
         if (_right == null)
         {
           _right = new DockBase(this);
           _right.SetupChildDock(pos);
         }
         dock = _right;
         break;

       case Pos.Top:
         if (_top == null)
         {
           _top = new DockBase(this);
           _top.SetupChildDock(pos);
         }
         dock = _top;
         break;

       case Pos.Bottom:
         if (_bottom == null)
         {
           _bottom = new DockBase(this);
           _bottom.SetupChildDock(pos);
         }
         dock = _bottom;
         break;
     }

     if (dock != null)
       dock.IsHidden = false;

     return dock;
   }

   /// <summary>
   /// Calculates dock direction from dragdrop coordinates.
   /// </summary>
   /// <param name="x">X coordinate.</param>
   /// <param name="y">Y coordinate.</param>
   /// <returns>Dock direction.</returns>
   Pos GetDroppedTabDirection(int x, int y)
   {
     int w = Width;
     int h = Height;
     double top = y / h;
     double left = x / w;
     double right = (w - x) / w;
     double bottom = (h - y) / h;
     double minimum = min(min(min(top, left), right), bottom);

     _dropFar = (minimum < 0.2);

     if (minimum > 0.3)
       return Pos.Fill;

     if (top == minimum && (null == _top || _top.IsHidden))
       return Pos.Top;
     if (left == minimum && (null == _left || _left.IsHidden))
       return Pos.Left;
     if (right == minimum && (null == _right || _right.IsHidden))
       return Pos.Right;
     if (bottom == minimum && (null == _bottom || _bottom.IsHidden))
       return Pos.Bottom;

     return Pos.Fill;
   }

   bool DragAndDrop_CanAcceptPackage(GwenPackage p)
   {
     // A TAB button dropped 
     if (p.Name == "TabButtonMove")
       return true;

     // a TAB window dropped
     if (p.Name == "TabWindowMove")
       return true;

     return false;
   }

   bool DragAndDrop_HandleDrop(GwenPackage p, int x, int y)
   {
     Point pos = CanvasPosToLocal(new Point(x, y));
     Pos dir = GetDroppedTabDirection(pos.x, pos.y);

     DockedTabControl addTo = _dockedTabControl;
     if (dir == Pos.Fill && addTo == null)
       return false;

     if (dir != Pos.Fill)
     {
       DockBase dock = GetChildDock(dir);
       addTo = dock._dockedTabControl;

       if (!_dropFar)
         dock.BringToFront();
       else
         dock.SendToBack();
     }

     if (p.Name == "TabButtonMove")
     {
       /* TODO: Implement Drag & Drop
       TabButton tabButton = DragAndDrop.SourceControl as TabButton;
       if (null == tabButton)
         return false;

       addTo.AddPage(tabButton);
       */
     }

     if (p.Name == "TabWindowMove")
     {
       /* TODO: Implement Drag & Drop 
       DockedTabControl tabControl = DragAndDrop.SourceControl as DockedTabControl;
       if (null == tabControl)
         return false;
       if (tabControl == addTo)
         return false;

       tabControl.MoveTabsTo(addTo);
       */
     }

     Invalidate();

     return true;
   }

   /// <summary>
   /// Indicates whether the control contains any docked children.
   /// </summary>
   bool get IsEmpty
   {

       if (_dockedTabControl != null && _dockedTabControl.TabCount > 0) return false;

       if (_left != null && !_left.IsEmpty) return false;
       if (_right != null && !_right.IsEmpty) return false;
       if (_top != null && !_top.IsEmpty) return false;
       if (_bottom != null && !_bottom.IsEmpty) return false;

       return true;

   }

   void OnTabRemoved(GwenControlBase control, GwenEventArgs args)
   {
     DoRedundancyCheck();
     DoConsolidateCheck();
   }

   void DoRedundancyCheck()
   {
     if (!IsEmpty) return;

     DockBase pDockParent = Parent as DockBase;
     if (null == pDockParent) return;

     pDockParent.OnRedundantChildDock(this);
   }

   void DoConsolidateCheck()
   {
     if (IsEmpty) return;
     if (null == _dockedTabControl) return;
     if (_dockedTabControl.TabCount > 0) return;

     if (_bottom != null && !_bottom.IsEmpty)
     {
       _bottom._dockedTabControl.MoveTabsTo(_dockedTabControl);
       return;
     }

     if (_top != null && !_top.IsEmpty)
     {
       _top._dockedTabControl.MoveTabsTo(_dockedTabControl);
       return;
     }

     if (_left != null && !_left.IsEmpty)
     {
       _left._dockedTabControl.MoveTabsTo(_dockedTabControl);
       return;
     }

     if (_right != null && !_right.IsEmpty)
     {
       _right._dockedTabControl.MoveTabsTo(_dockedTabControl);
       return;
     }
   }

   void OnRedundantChildDock(DockBase dock)
   {
     dock.IsHidden = true;
     DoRedundancyCheck();
     DoConsolidateCheck();
   }

   void DragAndDrop_HoverEnter(GwenPackage p, int x, int y)
   {
     _drawHover = true;
   }

   void DragAndDrop_HoverLeave(GwenPackage p)
   {
     _drawHover = false;
   }

   void DragAndDrop_Hover(GwenPackage p, int x, int y)
   {
     Point pos = CanvasPosToLocal(new Point(x, y));
     Pos dir = GetDroppedTabDirection(pos.x, pos.y);

     if (dir == Pos.Fill)
     {
       if (null == _dockedTabControl)
       {
         _hoverRect = new Rectangle(0, 0, 0, 0);
         return;
       }

       _hoverRect = InnerBounds;
       return;
     }

     _hoverRect = RenderBounds;
     
     int left=_hoverRect.left;
     int width = _hoverRect.width;
     int top = _hoverRect.top;
     int height = _hoverRect.height;

     int HelpBarWidth = 0;

     if (dir == Pos.Left)
     {
       HelpBarWidth = (width * 0.25).toInt();
       width = HelpBarWidth;
     }

     if (dir == Pos.Right)
     {
       HelpBarWidth = (width * 0.25).toInt();
       left = width - HelpBarWidth;
       width = HelpBarWidth;
     }

     if (dir == Pos.Top)
     {
       HelpBarWidth = (height * 0.25).toInt();
       height = HelpBarWidth;
     }

     if (dir == Pos.Bottom)
     {
       HelpBarWidth = (height * 0.25).toInt();
       top = height - HelpBarWidth;
       height = HelpBarWidth;
     }

     if ((dir == Pos.Top || dir == Pos.Bottom) && !_dropFar)
     {
       if (_left != null && _left.IsVisible)
       {
         left += _left.Width;
         width -= _left.Width;
       }

       if (_right != null && _right.IsVisible)
       {
         width -= _right.Width;
       }
     }

     if ((dir == Pos.Left || dir == Pos.Right) && !_dropFar)
     {
       if (_top != null && _top.IsVisible)
       {
         top += _top.Height;
         height -= _top.Height;
       }

       if (_bottom != null && _bottom.IsVisible)
       {
         height -= _bottom.Height;
       }
     }
     _hoverRect = new Rectangle(left, top, width, height);
   }

   /// <summary>
   /// Renders over the actual control (overlays).
   /// </summary>
   /// <param name="skin">Skin to use.</param>
   void RenderOver(GwenSkinBase skin)
   {
     if (!_drawHover)
       return;

     GwenRendererBase render = skin.Renderer;
     render.DrawColor = new Color.argb(20, 255, 200, 255);
     render.drawFilledRect(RenderBounds);

     if (_hoverRect.left == 0)
       return;

     render.DrawColor = new Color.argb(100, 255, 200, 255);
     render.drawFilledRect(_hoverRect);

     render.DrawColor = new Color.argb(200, 255, 200, 255);
     render.drawLinedRect(_hoverRect);
   }
}