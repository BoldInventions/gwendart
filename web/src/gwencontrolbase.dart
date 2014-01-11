part of gwendart;

//typedef void GwenEventHandler(GwenControlBase sender,  GwenEventArgs arguments);


class GwenControlBase
{
        bool m_Disposed;

        GwenControlBase m_Parent;

        /// <summary>
        /// This is the panel's actual parent - most likely the logical 
        /// parent's InnerPanel (if it has one). You should rarely need this.
        /// </summary>
        GwenControlBase m_ActualParent;

        /// <summary>
        /// If the innerpanel exists our children will automatically become children of that 
        /// instead of us - allowing us to move them all around by moving that panel (useful for scrolling etc).
        /// </summary>
        GwenControlBase m_InnerPanel;

        GwenControlBase m_ToolTip;

        GwenSkinBase m_Skin;

        Rectangle m_Bounds;
        Rectangle m_RenderBounds;
        Rectangle m_InnerBounds;
        GwenPadding m_Padding;
        GwenMargin m_Margin;

        String m_Name;

        bool m_RestrictToParent;
        bool m_Disabled;
        bool m_Hidden;
        bool m_MouseInputEnabled;
        bool m_KeyboardInputEnabled;
        bool m_DrawBackground;

        Pos m_Dock;

        CssCursor m_Cursor;

        bool m_Tabable;

        bool m_NeedsLayout;
        bool m_CacheTextureDirty;
        bool m_CacheToTexture;

        GwenPackage m_DragAndDrop_Package;

        Object m_UserData;

        bool m_DrawDebugOutlines;

        /// <summary>
        /// Real list of children.
        /// </summary>
        List<GwenControlBase> m_Children;

        /// <summary>
        /// Invoked when mouse pointer enters the control.
        /// </summary>
    GwenEventHandlerList HoverEnter=new GwenEventHandlerList();

        /// <summary>
        /// Invoked when mouse pointer leaves the control.
        /// </summary>
    GwenEventHandlerList HoverLeave=new GwenEventHandlerList();

        /// <summary>
        /// Invoked when control's bounds have been changed.
        /// </summary>
    GwenEventHandlerList BoundsChanged=new GwenEventHandlerList();

    /// <summary>
    /// Invoked when the control has been left-clicked.
    /// </summary>
    GwenEventHandlerList Clicked=new GwenEventHandlerList();

    /// <summary>
    /// Invoked when the control has been double-left-clicked.
    /// </summary>
    GwenEventHandlerList DoubleClicked=new GwenEventHandlerList();

    /// <summary>
    /// Invoked when the control has been right-clicked.
    /// </summary>
    GwenEventHandlerList RightClicked=new GwenEventHandlerList();

    /// <summary>
    /// Invoked when the control has been double-right-clicked.
    /// </summary>
    GwenEventHandlerList DoubleRightClicked=new GwenEventHandlerList();

    /// <summary>
    /// Returns true if any on click events are set.
    /// </summary>
    bool get ClickEventAssigned 
      {
        return Clicked != null || RightClicked != null || DoubleClicked != null || DoubleRightClicked != null;
      }
 

        /// <summary>
        /// Accelerator map.
        /// </summary>
        HashMap<String, GwenEventHandler> m_Accelerators;

        static const int MaxCoord = 4096; // added here from various places in code

        /// <summary>
        /// Logical list of children. If InnerPanel is not null, returns InnerPanel's children.
        /// </summary>
        List<GwenControlBase> get Children
        {
       
                if (m_InnerPanel != null)
                    return m_InnerPanel.Children;
                return m_Children;
            
        }

        /// <summary>
        /// The logical parent. It's usually what you expect, the control you've parented it to.
        /// </summary>
        GwenControlBase get Parent{ return m_Parent; }
            set Parent (GwenControlBase value)
            {
                if (m_Parent == value)
                    return;

                if (m_Parent != null)
                {
                    m_Parent.RemoveChild(this, false);
                }

                m_Parent = value;
                m_ActualParent = null;

                if (m_Parent != null)
                {
                    m_Parent.AddChild(this);
                }
            }


        // todo: ParentChanged event?

        /// <summary>
        /// Dock position.
        /// </summary>
        Pos get Dock{ return m_Dock; }
            set Dock (Pos value)
            {
                if (m_Dock == value)
                    return;

                m_Dock = value;

                Invalidate();
                InvalidateParent();
            }

        /// <summary>
        /// Current skin.
        /// </summary>
        GwenSkinBase get Skin
        {
           GwenSkinBase retSkin=null;
           
           if (m_Skin != null)
           {
                    retSkin = m_Skin;
           } else
           {
                
                if (m_Parent != null)
                {
                    retSkin =  m_Parent.Skin;
                } else
                {

                  throw new ArgumentError("GwenControlBase.GetSkin: null");
                }
           }
           return retSkin;
        }
        

        /// <summary>
        /// Current tooltip.
        /// </summary>
        GwenControlBase get ToolTip
        { return m_ToolTip; }
            set ToolTip (GwenControlBase value)
            {
                m_ToolTip = value;
                if (m_ToolTip != null)
                {
                    m_ToolTip.Parent = this;
                    m_ToolTip.IsHidden = true;
                }
            }

        /// <summary>
        /// Indicates whether this control is a menu component.
        /// </summary>
        bool get IsMenuComponent
        {
                if (m_Parent == null)
                    return false;
                return m_Parent.IsMenuComponent;
            }


        /// <summary>
        /// Determines whether the control should be clipped to its bounds while rendering.
        /// </summary>
        bool get ShouldClip {  return true; } 

        /// <summary>
        /// Current padding - inner spacing.
        /// </summary>
        GwenPadding get Padding
        {
            return m_Padding; }
            set Padding (GwenPadding value)
            {
                if (m_Padding == value)
                    return;

                m_Padding = value;
                Invalidate();
                InvalidateParent();
            }
      

        /// <summary>
        /// Current margin - outer spacing.
        /// </summary>
        GwenMargin get Margin
        {
             return m_Margin; }
            set Margin (GwenMargin value)
            {
                if (m_Margin == value)
                    return;

                m_Margin = value;
                Invalidate();
                InvalidateParent();
            }
        

        /// <summary>
        /// Indicates whether the control is on top of its parent's children.
        /// </summary>
        bool get IsOnTop { return this == Parent.m_Children[0]; }  // todo: validate

        /// <summary>
        /// User data associated with the control.
        /// </summary>
        Object get UserData  { return m_UserData; } set UserData( Object value) { m_UserData = value; }

        /// <summary>
        /// Indicates whether the control is hovered by mouse pointer.
        /// </summary>
        bool get IsHovered  { return InputHandler.HoveredControl == this; }

        /// <summary>
        /// Indicates whether the control has focus.
        /// </summary>
        bool get HasFocus  { return InputHandler.KeyboardFocus == this; }

        /// <summary>
        /// Indicates whether the control is disabled.
        /// </summary>
        bool get IsDisabled  { return m_Disabled; } set IsDisabled (bool value) { m_Disabled = value; }

        /// <summary>
        /// Indicates whether the control is hidden.
        /// </summary>
        bool get IsHidden  { return m_Hidden; } set IsHidden (bool value) { 
          
        if (value == m_Hidden) return; m_Hidden = value; Invalidate(); }

        /// <summary>
        /// Determines whether the control's position should be restricted to parent's bounds.
        /// </summary>
        bool get RestrictToParent  { return m_RestrictToParent; } set RestrictToParent (bool value)  { m_RestrictToParent = value; }

        /// <summary>
        /// Determines whether the control receives mouse input events.
        /// </summary>
        bool get MouseInputEnabled  { return m_MouseInputEnabled; } set MouseInputEnabled (bool value) { m_MouseInputEnabled = value; }

        /// <summary>
        /// Determines whether the control receives keyboard input events.
        /// </summary>
        bool get KeyboardInputEnabled  { return m_KeyboardInputEnabled; } 
        set KeyboardInputEnabled(bool value) { m_KeyboardInputEnabled = value; }

        /// <summary>
        /// Gets or sets the mouse cursor when the cursor is hovering the control.
        /// </summary>
        CssCursor get Cursor  
        { 
          return m_Cursor; 
        } 
        
        
        set Cursor(CssCursor value) 
        { 
          m_Cursor = value; 
        }

        /// <summary>
        /// Indicates whether the control is tabable (can be focused by pressing Tab).
        /// </summary>
        bool get IsTabable  { return m_Tabable; } set IsTabable(bool value) { m_Tabable = value; }

        /// <summary>
        /// Indicates whether control's background should be drawn during rendering.
        /// </summary>
        bool get ShouldDrawBackground  { return m_DrawBackground; } set ShouldDrawBackground(bool value) { m_DrawBackground = value; } 

        /// <summary>
        /// Indicates whether the renderer should cache drawing to a texture to improve performance (at the cost of memory).
        /// </summary>
        bool get ShouldCacheToTexture  { return m_CacheToTexture; } 
        set ShouldCacheToTexture(bool value) { m_CacheToTexture = value; } /*Children.ForEach(x => x.ShouldCacheToTexture=value);*/ 

        /// <summary>
        /// Gets or sets the control's name.
        /// </summary>
        String get Name  { return m_Name; } set Name(String value) { m_Name = value; }

        /// <summary>
        /// Control's size and position relative to the parent.
        /// </summary>
        Rectangle get Bounds  { return m_Bounds; }

        /// <summary>
        /// Bounds for the renderer.
        /// </summary>
        Rectangle get RenderBounds  { return m_RenderBounds; }
        
        Rectangle addToRenderBounds( Rectangle r )
        {
          
          bool bChanged=false;
          num left = m_RenderBounds.left;
          if(r.left < left) { left = r.left; bChanged = true; }
          num right = m_RenderBounds.right;
          if(r.right > right) { right = r.right; bChanged = true; }
          num top = m_RenderBounds.top;
          if(r.top < top) { top =  r.top; bChanged = true; }
          num bottom = m_RenderBounds.bottom;
          if(r.bottom > bottom) { bottom =  r.bottom; bChanged = true; }
          if(bChanged)
          {
             m_RenderBounds = new Rectangle(left, top, right-left, bottom-top);
          }
          return m_RenderBounds;
        }

        /// <summary>
        /// Bounds adjusted by padding.
        /// </summary>
        Rectangle get InnerBounds  { return m_InnerBounds; }

        /// <summary>
        /// Size restriction.
        /// </summary>
        Point<int> get MinimumSize  { return m_MinimumSize; } set MinimumSize(Point<int> value) { m_MinimumSize = new Point<int>(value.x, value.y); }

        /// <summary>
        /// Size restriction.
        /// </summary>
        Point<int> get MaximumSize  { return m_MaximumSize; } set MaximumSize(Point<int> value){ m_MaximumSize = value; }

        Point<int>  m_MinimumSize = new Point<int>(1, 1);
        Point<int>  m_MaximumSize = new Point<int>(MaxCoord, MaxCoord);

        /// <summary>
        /// Determines whether hover should be drawn during rendering.
        /// </summary>
        bool get ShouldDrawHover  { return InputHandler.MouseFocus == this || InputHandler.MouseFocus == null; }

        bool get AccelOnlyFocus  { return false; }
        bool get NeedsInputChars  { return false; }

        /// <summary>
        /// Indicates whether the control and its parents are visible.
        /// </summary>
        bool get IsVisible
        {
                if (IsHidden)
                    return false;

                if (Parent != null)
                    return Parent.IsVisible;

                return true;
            }
        

        /// <summary>
        /// Leftmost coordinate of the control.
        /// </summary>
        int get X  { return m_Bounds.left; } set X(int value) { SetPosition(value, Y); }

        /// <summary>
        /// Topmost coordinate of the control.
        /// </summary>
        int  get Y  { return m_Bounds.top; } set Y(int value) { SetPosition(X, value); }

        // todo: Bottom/Right includes margin but X/Y not?

        int get Width  { return m_Bounds.width; } set Width(int value){ SetSize(value, Height); }
        int get Height  { return m_Bounds.height; } set Height(int value) { SetSize(Width, value); }
        int get Bottom  { return m_Bounds.bottom + m_Margin.Bottom; }
        int get Right  { return m_Bounds.right + m_Margin.Right; }

        /// <summary>
        /// Determines whether margin, padding and bounds outlines for the control will be drawn. Applied recursively to all children.
        /// </summary>
        bool get DrawDebugOutlines
        {
            return m_DrawDebugOutlines; }
            set DrawDebugOutlines (bool value)
            {
                if (m_DrawDebugOutlines == value)
                    return;
                m_DrawDebugOutlines = value;
                for(GwenControlBase child in Children)
                {
                    child.DrawDebugOutlines = value;
                }
            }
   

        Color PaddingOutlineColor;
 
        Color MarginOutlineColor ;  
        Color  BoundsOutlineColor; 

        /// <summary>
        /// Initializes a new instance of the <see cref="Base"/> class.
        /// </summary>
        /// <param name="parent">Parent control.</param>
        GwenControlBase([GwenControlBase parent = null])
        {
            m_DrawDebugOutlines = false;
            m_Children = new List<GwenControlBase>();
            m_Accelerators = new HashMap<String, GwenEventHandler>();
            m_RenderBounds = new Rectangle<int>(0, 0, 0, 0);

            Parent = parent;

            m_Hidden = false;
            m_Bounds = new Rectangle(0, 0, 10, 10);
            m_Padding = GwenPadding.Zero;
            m_Margin = GwenMargin.Zero;

            RestrictToParent = false;

            MouseInputEnabled = true;
            KeyboardInputEnabled = false;
            
            m_Dock = Pos.None;

            Invalidate();
            Cursor = CssCursor.Default;
            //ToolTip = null;
            IsTabable = false;
            ShouldDrawBackground = true;
            m_Disabled = false;
            m_CacheTextureDirty = true;
            m_CacheToTexture = false;

            BoundsOutlineColor = Color.Red;
            MarginOutlineColor = Color.Green;
            PaddingOutlineColor = Color.Blue;
        }

        /// <summary>
        /// Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
        /// </summary>
        void Dispose()
        {
/*

            if (InputHandler.HoveredControl == this)
                InputHandler.HoveredControl = null;
            if (InputHandler.KeyboardFocus == this)
                InputHandler.KeyboardFocus = null;
            if (InputHandler.MouseFocus == this)
                InputHandler.MouseFocus = null;

            DragAndDrop.ControlDeleted(this);
            Gwen.ToolTip.ControlDeleted(this);
            Animation.Cancel(this);

            for(GwenControlBase child in m_Children)
                child.Dispose();

            m_Children.Clear();

            m_Disposed = true;
            GC.SuppressFinalize(this);
            */
        }
/*
#if DEBUG
        ~Base()
        {
            throw new InvalidOperationException(String.Format("IDisposable Object finalized [{1:X}]: {0}", this, GetHashCode()));
            //Debug.Print(String.Format("IDisposable Object finalized: {0}", GetType()));
        }
#endif
*/
        /// <summary>
        /// Detaches the control from canvas and adds to the deletion queue (processed in Canvas.DoThink).
        /// </summary>
        void DelayedDelete()
        {
            GetCanvas().AddDelayedDelete(this);
        }

        String ToString()
        {
          /*
            if (this is MenuItem)
                return "[MenuItem: " + (this as MenuItem).Text + "]";
            if (this is Label)
                return "[Label: " + (this as Label).Text + "]";
            if (this is ControlInternal.Text)
                return "[Text: " + (this as ControlInternal.Text).String + "]";
          */
            return runtimeType.toString();
        }

        /// <summary>
        /// Gets the canvas (root parent) of the control.
        /// </summary>
        /// <returns></returns>
        GwenControlCanvas GetCanvas()
        {
            GwenControlBase canvas = m_Parent;
            if (canvas == null)
                return null;

            return canvas.GetCanvas();
        }

        /// <summary>
        /// Enables the control.
        /// </summary>
        void Enable()
        {
            IsDisabled = false;
        }

        /// <summary>
        /// Disables the control.
        /// </summary>
        void Disable()
        {
            IsDisabled = true;
        }

        /// <summary>
        /// Default accelerator handler.
        /// </summary>
        /// <param name="control">Event source.</param>
        void DefaultAcceleratorHandler(GwenControlBase control, GwenEventArgs args)
        {
            OnAccelerator();
        }

        /// <summary>
        /// Default accelerator handler.
        /// </summary>
        void OnAccelerator()
        {

        }

        /// <summary>
        /// Hides the control.
        /// </summary>
        void Hide()
        {
            IsHidden = true;
        }

        /// <summary>
        /// Shows the control.
        /// </summary>
        void Show()
        {
            IsHidden = false;
        }

        /// <summary>
        /// Creates a tooltip for the control.
        /// </summary>
        /// <param name="text">Tooltip text.</param>
        void SetToolTipText(String text)
        {
          // TODO: Implement ToolTips
          /*
            Label tooltip = new Label(this);
            tooltip.Text = text;
            tooltip.TextColorOverride = Skin.SkinColors.m_TooltipText;
            tooltip.Padding = new GwenPadding(5, 3, 5, 3);
            tooltip.SizeToContents();

            ToolTip = tooltip;
            */
        }

        /// <summary>
        /// Invalidates the control's children (relayout/repaint).
        /// </summary>
        /// <param name="recursive">Determines whether the operation should be carried recursively.</param>
        void InvalidateChildren([bool recursive = false])
        {
            for(GwenControlBase child in m_Children)
            {
                child.Invalidate();
                if (recursive)
                    child.InvalidateChildren(true);
            }

            if (m_InnerPanel != null)
            {
                for(GwenControlBase child in m_InnerPanel.m_Children)
                {
                    child.Invalidate();
                    if (recursive)
                        child.InvalidateChildren(true);
                }
            }
        }

        /// <summary>
        /// Invalidates the control.
        /// </summary>
        /// <remarks>
        /// Causes layout, repaint, invalidates cached texture.
        /// </remarks>
        void Invalidate()
        {
            m_NeedsLayout = true;
            m_CacheTextureDirty = true;
        }

        /// <summary>
        /// Sends the control to the bottom of paren't visibility stack.
        /// </summary>
        void SendToBack()
        {
            if (m_ActualParent == null)
                return;
            if (m_ActualParent.m_Children.length == 0)
                return;
            if (m_ActualParent.m_Children[0] == this)
                return;

            m_ActualParent.m_Children.remove(this);
            m_ActualParent.m_Children.insert(0, this);

            InvalidateParent();
        }

        /// <summary>
        /// Brings the control to the top of paren't visibility stack.
        /// </summary>
        void BringToFront()
        {
            if (m_ActualParent == null)
                return;
            if ( (0 < m_ActualParent.m_Children.length) && m_ActualParent.m_Children[m_ActualParent.m_Children.length-1] == this)
                return;

            m_ActualParent.m_Children.remove(this);
            m_ActualParent.m_Children.add(this);
            InvalidateParent();
            Redraw();
        }

        void BringNextToControl(GwenControlBase child, bool behind)
        {
            if (null == m_ActualParent)
                return;

            m_ActualParent.m_Children.remove(this);

            // todo: validate
            int idx = m_ActualParent.m_Children.indexOf(child);
            if (idx == m_ActualParent.m_Children.length - 1)
            {
                BringToFront();
                return;
            }

            if (behind)
            {
                ++idx;

                if (idx == m_ActualParent.m_Children.length - 1)
                {
                    BringToFront();
                    return;
                }
            }

            m_ActualParent.m_Children.insert(idx, this);
            InvalidateParent();
        }

        /// <summary>
        /// Finds a child by name.
        /// </summary>
        /// <param name="name">Child name.</param>
        /// <param name="recursive">Determines whether the search should be recursive.</param>
        /// <returns>Found control or null.</returns>
        GwenControlBase FindChildByName(String name, [bool recursive = false])
        {
          GwenControlBase b;
            for(GwenControlBase c in m_Children)
            {
              if(c.m_Name == name)
              {
                b=c;
                break;
              }
            }

            if (b != null)
                return b;

            if (recursive)
            {
                for(GwenControlBase child in m_Children)
                {
                    b = child.FindChildByName(name, true);
                    if (b != null)
                        return b;
                }
            }
            return null;
        }

        /// <summary>
        /// Attaches specified control as a child of this one.
        /// </summary>
        /// <remarks>
        /// If InnerPanel is not null, it will become the parent.
        /// </remarks>
        /// <param name="child">Control to be added as a child.</param>
        void AddChild(GwenControlBase child)
        {
      if (m_InnerPanel != null) {
        m_InnerPanel.AddChild(child);
      } else {
        m_Children.add(child);
        child.m_ActualParent = this;
      }
      OnChildAdded(child);
        }

        /// <summary>
        /// Detaches specified control from this one.
        /// </summary>
        /// <param name="child">Child to be removed.</param>
        /// <param name="dispose">Determines whether the child should be disposed (added to delayed delete queue).</param>
        void RemoveChild(GwenControlBase child, bool dispose)
        {
            // If we removed our innerpanel
            // remove our pointer to it
            if (m_InnerPanel == child)
            {
                m_Children.remove(m_InnerPanel);
                m_InnerPanel.DelayedDelete();
                m_InnerPanel = null;
                return;
            }

            if (m_InnerPanel != null && m_InnerPanel.Children.contains(child))
            {
                m_InnerPanel.RemoveChild(child, dispose);
                return;
            }

            m_Children.remove(child);
            OnChildRemoved(child);

            if (dispose)
                child.DelayedDelete();
        }

        /// <summary>
        /// Removes all children (and disposes them).
        /// </summary>
        void DeleteAllChildren()
        {
            // todo: probably shouldn't invalidate after each removal
            while (m_Children.length > 0)
                RemoveChild(m_Children[0], true);
        }

        /// <summary>
        /// Handler invoked when a child is added.
        /// </summary>
        /// <param name="child">Child added.</param>
        void OnChildAdded(GwenControlBase child)
        {
            Invalidate();
        }

        /// <summary>
        /// Handler invoked when a child is removed.
        /// </summary>
        /// <param name="child">Child removed.</param>
        void OnChildRemoved(GwenControlBase child)
        {
            Invalidate();
        }

        /// <summary>
        /// Moves the control by a specific amount.
        /// </summary>
        /// <param name="x">X-axis movement.</param>
        /// <param name="y">Y-axis movement.</param>
        void MoveBy(int ix, int iy)
        {
            SetBounds(X + ix, Y + iy, Width, Height);
        }

        /// <summary>
        /// Moves the control to a specific point.
        /// </summary>
        /// <param name="x">Target x coordinate.</param>
        /// <param name="y">Target y coordinate.</param>
        void MoveToDbl(double fx, double fy)
        {
            MoveTo(fx.toInt(), fy.toInt());
        }

        /// <summary>
        /// Moves the control to a specific point, clamping on paren't bounds if RestrictToParent is set.
        /// </summary>
        /// <param name="x">Target x coordinate.</param>
        /// <param name="y">Target y coordinate.</param>
        void MoveTo(int ix, int iy)
        {
            if (RestrictToParent && (Parent != null))
            {
                GwenControlBase parent = Parent;
                if (ix - Padding.Left < parent.Margin.Left)
                    ix = parent.Margin.Left + Padding.Left;
                if (iy - Padding.Top < parent.Margin.Top)
                    iy = parent.Margin.Top + Padding.Top;
                if( ix + Width + Padding.Right > parent.Width - parent.Margin.Right)
                    ix = parent.Width - parent.Margin.Right - Width - Padding.Right;
                if (iy + Height + Padding.Bottom > parent.Height - parent.Margin.Bottom)
                    iy = parent.Height - parent.Margin.Bottom - Height - Padding.Bottom;
            }

            SetBounds(ix, iy, Width, Height);
        }

        /// <summary>
        /// Sets the control position.
        /// </summary>
        /// <param name="x">Target x coordinate.</param>
        /// <param name="y">Target y coordinate.</param>
        void SetPositionDbl(double x, double y)
        {
            SetPosition(x.toInt(), y.toInt());
        }

        /// <summary>
        /// Sets the control position.
        /// </summary>
        /// <param name="x">Target x coordinate.</param>
        /// <param name="y">Target y coordinate.</param>
        void SetPosition(int x, int y)
        {
            SetBounds(x, y, Width, Height);
        }

        /// <summary>
        /// Sets the control size.
        /// </summary>
        /// <param name="width">New width.</param>
        /// <param name="height">New height.</param>
        /// <returns>True if bounds changed.</returns>
        bool SetSize(int width, int height)
        {
            return SetBounds(X, Y, width, height);
        }

        /// <summary>
        /// Sets the control bounds.
        /// </summary>
        /// <param name="bounds">New bounds.</param>
        /// <returns>True if bounds changed.</returns>
        bool SetBoundsRect(Rectangle bounds)
        {
            return SetBounds(bounds.left, bounds.top, bounds.width, bounds.height);
        }

        /// <summary>
        /// Sets the control bounds.
        /// </summary>
        /// <param name="x">X.</param>
        /// <param name="y">Y.</param>
        /// <param name="width">Width.</param>
        /// <param name="height">Height.</param>
        /// <returns>
        /// True if bounds changed.
        /// </returns>
        bool SetBoundsDbl(double x, double y, double width, double height)
        {
            return SetBounds(x.toInt(), y.toInt(), width.toInt(), height.toInt());
        }

        /// <summary>
        /// Sets the control bounds.
        /// </summary>
        /// <param name="x">X position.</param>
        /// <param name="y">Y position.</param>
        /// <param name="width">Width.</param>
        /// <param name="height">Height.</param>
        /// <returns>
        /// True if bounds changed.
        /// </returns>
        bool SetBounds(int x, int y, int width, int height)
        {
            if (m_Bounds.left == x &&
                m_Bounds.top == y &&
                m_Bounds.width == width &&
                m_Bounds.height == height)
                return false;

            Rectangle oldBounds = Bounds;

            //m_Bounds.left = x;
            //m_Bounds.top = y;

            //m_Bounds.width = width;
            //m_Bounds.height = height;
            
            m_Bounds = new Rectangle<int>(x, y, width, height);

            OnBoundsChanged(oldBounds);

            if (BoundsChanged != null) // new Future(() { BoundsChanged(this, GwenEventArgs.Empty); });
                BoundsChanged.Invoke(this, GwenEventArgs.Empty);

            return true;
        }

        /// <summary>
        /// Positions the control inside its parent.
        /// </summary>
        /// <param name="pos">Target position.</param>
        /// <param name="xpadding">X padding.</param>
        /// <param name="ypadding">Y padding.</param>
        void Position(Pos pos, [int xpadding = 0, int ypadding = 0]) // todo: a bit ambiguous name
        {
            int w = Parent.Width;
            int h = Parent.Height;
            GwenPadding padding = Parent.Padding;

            int x = X;
            int y = Y;
            if (0 != (pos.value & Pos.Left.value)) x = padding.Left + xpadding;
            if (0 != (pos.value & Pos.Right.value)) x = w - Width - padding.Right - xpadding;
            if (0 != (pos.value & Pos.CenterH.value))
                x = (padding.Left + xpadding + (w - Width - padding.Left - padding.Right) * 0.5).round();

            if (0 != (pos.value & Pos.Top.value)) y = padding.Top + ypadding;
            if (0 != (pos.value & Pos.Bottom.value)) y = h - Height - padding.Bottom - ypadding;
            if (0 != (pos.value & Pos.CenterV.value))
                y = (padding.Top + ypadding + (h - Height - padding.Bottom - padding.Top) * 0.5).round();

            SetPosition(x, y);
        }

        /// <summary>
        /// Handler invoked when control's bounds change.
        /// </summary>
        /// <param name="oldBounds">Old bounds.</param>
        void OnBoundsChanged(Rectangle oldBounds)
        {
            //Anything that needs to update on size changes
            //Iterate my children and tell them I've changed
            //
            if (Parent != null)
                Parent.OnChildBoundsChanged(oldBounds, this);


            if (m_Bounds.width != oldBounds.width || m_Bounds.height != oldBounds.height)
            {
                Invalidate();
            }

            Redraw();
            UpdateRenderBounds();
        }

        /// <summary>
        /// Handler invoked when control's scale changes.
        /// </summary>
        void OnScaleChanged()
        {
            for(GwenControlBase child in m_Children)
            {
                child.OnScaleChanged();
            }
        }

        /// <summary>
        /// Handler invoked when control children's bounds change.
        /// </summary>
        void OnChildBoundsChanged(Rectangle oldChildBounds, GwenControlBase child)
        {

        }

        /// <summary>
        /// Renders the control using specified skin.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void Render(GwenSkinBase skin)
        {
        }

        /// <summary>
        /// Renders the control to a cache using specified skin.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        /// <param name="master">Root parent.</param>
        void DoCacheRender(GwenSkinBase skin, GwenControlBase master)
        {
            GwenRendererBase render = skin.Renderer;
            ICacheToTexture cache = render.CTT;

            if (cache == null)
                return;

            Point oldRenderOffset = render.RenderOffset;
            Rectangle oldRegion = render.ClipRegion;

            if (this != master)
            {
                render.AddRenderOffset(Bounds);
                render.AddClipRegion(Bounds);
            }
            else
            {
                render.RenderOffset = new Point<int>(0,0);
                render.ClipRegion = new Rectangle(0, 0, Width, Height);
            }

            if (m_CacheTextureDirty && render.ClipRegionVisible)
            {
                render.startClip();

                if (ShouldCacheToTexture)
                    cache.setupCacheTexture(this);

                //Render myself first
                //var old = render.ClipRegion;
                //render.ClipRegion = Bounds;
                //var old = render.RenderOffset;
                //render.RenderOffset = new Point(Bounds.x, Bounds.y);
                Render(skin);
                //render.RenderOffset = old;
                //render.ClipRegion = old;

                if (m_Children.length > 0)
                {
                    //Now render my kids
                    for(GwenControlBase child in m_Children)
                    {
                        if (child.IsHidden)
                            continue;
                        child.DoCacheRender(skin, master);
                    }
                }

                if (ShouldCacheToTexture)
                {
                    cache.finishCacheTexture(this);
                    m_CacheTextureDirty = false;
                }
            }

            render.ClipRegion = oldRegion;
            render.startClip();
            render.RenderOffset = oldRenderOffset;

            if (ShouldCacheToTexture)
                cache.drawCachedControlTexture(this);
        }

        /// <summary>
        /// Rendering logic implementation.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void DoRender(GwenSkinBase skin)
        {
            // If this control has a different skin, 
            // then so does its children.
            if (m_Skin != null)
                skin = m_Skin;

            // Do think
            Think();

            GwenRendererBase render = skin.Renderer;

            if (render.CTT != null && ShouldCacheToTexture)
            {
                DoCacheRender(skin, this);
                return;
            }

            RenderRecursive(skin, Bounds);

            if (DrawDebugOutlines)
                skin.DrawDebugOutlines(this);
        }

        /// <summary>
        /// Recursive rendering logic.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        /// <param name="clipRect">Clipping rectangle.</param>
        void RenderRecursive(GwenSkinBase skin, Rectangle clipRect)
        {
            GwenRendererBase render = skin.Renderer;
            Point oldRenderOffset = render.RenderOffset;

            render.AddRenderOffset(clipRect);

            RenderUnder(skin);

            Rectangle oldRegion = render.ClipRegion;

            if (ShouldClip)
            {
                render.AddClipRegion(clipRect);

                if (!render.ClipRegionVisible)
                {
                    render.RenderOffset = oldRenderOffset;
                    render.ClipRegion = oldRegion;
                    return;
                }

                render.startClip();
            }

            //Render myself first
            Render(skin);

            if (m_Children.length > 0)
            {
                //Now render my kids
                for(GwenControlBase child in m_Children)
                {
                    if (child.IsHidden)
                        continue;
                    child.DoRender(skin);
                }
            }

            render.ClipRegion = oldRegion;
            render.startClip();
            RenderOver(skin);

            RenderFocus(skin);

            render.RenderOffset = oldRenderOffset;
        }

        /// <summary>
        /// Sets the control's skin.
        /// </summary>
        /// <param name="skin">New skin.</param>
        /// <param name="doChildren">Deterines whether to change children skin.</param>
        void SetSkin(GwenSkinBase skin, [bool doChildren = false])
        {
            if (m_Skin == skin)
                return;
            m_Skin = skin;
            Invalidate();
            Redraw();
            OnSkinChanged(skin);

            if (doChildren)
            {
                for(GwenControlBase child in m_Children)
                {
                    child.SetSkin(skin, true);
                }
            }
        }

        /// <summary>
        /// Handler invoked when control's skin changes.
        /// </summary>
        /// <param name="newSkin">New skin.</param>
        void OnSkinChanged(GwenSkinBase newSkin)
        {

        }

        /// <summary>
        /// Handler invoked on mouse wheel event.
        /// </summary>
        /// <param name="delta">Scroll delta.</param>
        bool OnMouseWheeled(int delta)
        {
            if (m_ActualParent != null)
                return m_ActualParent.OnMouseWheeled(delta);

            return false;
        }

        /// <summary>
        /// Invokes mouse wheeled event (used by input system).
        /// </summary>
        bool InputMouseWheeled(int delta)
        {
            return OnMouseWheeled(delta);
        }

        /// <summary>
        /// Handler invoked on mouse moved event.
        /// </summary>
        /// <param name="x">X coordinate.</param>
        /// <param name="y">Y coordinate.</param>
        /// <param name="dx">X change.</param>
        /// <param name="dy">Y change.</param>
        void OnMouseMoved(int x, int y, int dx, int dy)
        {

        }

        /// <summary>
        /// Invokes mouse moved event (used by input system).
        /// </summary>
        void InputMouseMoved(int x, int y, int dx, int dy)
        {
            OnMouseMoved(x, y, dx, dy);
        }

        /// <summary>
        /// Handler invoked on mouse click (left) event.
        /// </summary>
        /// <param name="x">X coordinate.</param>
        /// <param name="y">Y coordinate.</param>
        /// <param name="down">If set to <c>true</c> mouse button is down.</param>
        void OnMouseClickedLeft(int x, int y, bool down)
        {
      if (down && Clicked != null)
        Clicked.Invoke(this, new ClickedEventArgs(x, y, down));
        }

        /// <summary>
        /// Invokes left mouse click event (used by input system).
        /// </summary>
        void InputMouseClickedLeft(int x, int y, bool down)
        {
            OnMouseClickedLeft(x, y, down);
        }

        /// <summary>
        /// Handler invoked on mouse click (right) event.
        /// </summary>
        /// <param name="x">X coordinate.</param>
        /// <param name="y">Y coordinate.</param>
        /// <param name="down">If set to <c>true</c> mouse button is down.</param>
        void OnMouseClickedRight(int x, int y, bool down)
        {
      if (down && RightClicked != null)
        RightClicked.Invoke(this, new ClickedEventArgs(x, y, down));
        }

        /// <summary>
        /// Invokes right mouse click event (used by input system).
        /// </summary>
        void InputMouseClickedRight(int x, int y, bool down)
        {
            OnMouseClickedRight(x, y, down);
        }

        /// <summary>
        /// Handler invoked on mouse double click (left) event.
        /// </summary>
        /// <param name="x">X coordinate.</param>
        /// <param name="y">Y coordinate.</param>
        void OnMouseDoubleClickedLeft(int x, int y)
        {
      // [omeg] should this be called?
      // [halfofastaple] Maybe. Technically, a double click is still technically a single click. However, this shouldn't be called here, and
      //          Should be called by the event handler.
            OnMouseClickedLeft(x, y, true);

      if (DoubleClicked != null)
        DoubleClicked.Invoke(this, new ClickedEventArgs(x, y, true));
        }

        /// <summary>
        /// Invokes left double mouse click event (used by input system).
        /// </summary>
        void InputMouseDoubleClickedLeft(int x, int y)
        {
            OnMouseDoubleClickedLeft(x, y);
        }

        /// <summary>
        /// Handler invoked on mouse double click (right) event.
        /// </summary>
        /// <param name="x">X coordinate.</param>
        /// <param name="y">Y coordinate.</param>
        void OnMouseDoubleClickedRight(int x, int y)
        {
      // [halfofastaple] See: OnMouseDoubleClicked for discussion on triggering single clicks in a double click event
            OnMouseClickedRight(x, y, true);

      if (DoubleRightClicked != null)
        DoubleRightClicked.Invoke(this, new ClickedEventArgs(x, y, true));
        }

        /// <summary>
        /// Invokes right double mouse click event (used by input system).
        /// </summary>
        void InputMouseDoubleClickedRight(int x, int y)
        {
            OnMouseDoubleClickedRight(x, y);
        }

        /// <summary>
        /// Handler invoked on mouse cursor entering control's bounds.
        /// </summary>
        void OnMouseEntered()
        {
            if (HoverEnter != null)
        HoverEnter.Invoke(this, GwenEventArgs.Empty);

            /// TODO:  Implement ToolTips
            /*
            if (ToolTip != null)
                Gwen.ToolTip.Enable(this);
            else if (Parent != null && Parent.ToolTip != null)
                Gwen.ToolTip.Enable(Parent);
            */
            Redraw();
        }

        /// <summary>
        /// Invokes mouse enter event (used by input system).
        /// </summary>
        void InputMouseEntered()
        {
            OnMouseEntered();
        }

        /// <summary>
        /// Handler invoked on mouse cursor leaving control's bounds.
        /// </summary>
        void OnMouseLeft()
        {
            if (HoverLeave != null)
        HoverLeave.Invoke(this, GwenEventArgs.Empty);

            /// TODO: Implement Tooltips
            /*
            if (ToolTip != null)
                Gwen.ToolTip.Disable(this);
            */
            Redraw();
        }

        /// <summary>
        /// Invokes mouse leave event (used by input system).
        /// </summary>
        void InputMouseLeft()
        {
            OnMouseLeft();
        }

        /// <summary>
        /// Focuses the control.
        /// </summary>
        void Focus()
        {
            if (InputHandler.KeyboardFocus == this)
                return;

            if (InputHandler.KeyboardFocus != null)
                InputHandler.KeyboardFocus.OnLostKeyboardFocus();

            InputHandler.KeyboardFocus = this;
            OnKeyboardFocus();
            Redraw();
        }

        /// <summary>
        /// Unfocuses the control.
        /// </summary>
        void Blur()
        {
            if (InputHandler.KeyboardFocus != this)
                return;

            InputHandler.KeyboardFocus = null;
            OnLostKeyboardFocus();
            Redraw();
        }

        /// <summary>
        /// Control has been clicked - invoked by input system. Windows use it to propagate activation.
        /// </summary>
        void Touch()
        {
            if (Parent != null)
                Parent.OnChildTouched(this);
        }

        void OnChildTouched(GwenControlBase control)
        {
            Touch();
        }

        /// <summary>
        /// Gets a child by its coordinates.
        /// </summary>
        /// <param name="x">Child X.</param>
        /// <param name="y">Child Y.</param>
        /// <returns>Control or null if not found.</returns>
        GwenControlBase GetControlAt(int x, int y)
        {
            if (IsHidden)
                return null;

            if (x < 0 || y < 0 || x >= Width || y >= Height)
                return null;

            // todo: convert to linq FindLast
            GwenControlBase found=null; 
            int count = m_Children.length;
            int i;
            GwenControlBase child=null;
            //for(GwenControlBase child in m_Children)
            for(i=count-1; i>=0; i--)
            {
             // if(child is Button)
             // {
             //   if(GwenRenderer.g_bShiftKeyDown)
             //   {
             //   if(x < -100000) return null; // nonsense line for debugging.
             //   }
             // }
              child=m_Children[i];
              found = child.GetControlAt(x - child.X, y - child.Y);
              if(null!=found) return found;
            }


            if (!MouseInputEnabled)
                return null;

            return this;
        }

        /// <summary>
        /// Lays out the control's interior according to alignment, padding, dock etc.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void Layout(GwenSkinBase skin)
        {
            if (skin.Renderer.CTT != null && ShouldCacheToTexture)
                skin.Renderer.CTT.createControlCacheTexture(this);
        }

        /// <summary>
        /// Recursively lays out the control's interior according to alignment, margin, padding, dock etc.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void RecurseLayout(GwenSkinBase skin)
        {
            if (m_Skin != null)
                skin = m_Skin;
            if (IsHidden)
                return;

            if (m_NeedsLayout)
            {
                m_NeedsLayout = false;
                Layout(skin);
            }

            Rectangle bounds = RenderBounds;
            if(null == bounds)
            {
              throw new StateError("GwenControlBase.RecurseLayout() RenderBounds is null");
            }
            
            int left = bounds.left;
            int width = bounds.width;
            int top = bounds.top;
            int height = bounds.height;

            // Adjust bounds for padding
            left += m_Padding.Left;
            width -= m_Padding.Left + m_Padding.Right;
            top += m_Padding.Top;
            height -= m_Padding.Top + m_Padding.Bottom;

            for(GwenControlBase child in m_Children)
            {
                if (child.IsHidden)
                    continue;

                Pos dock = child.Dock;

                if (0 != (dock.value & Pos.Fill.value))
                    continue;

                if (0 != (dock.value & Pos.Top.value))
                {
                    GwenMargin margin = child.Margin;

                    child.SetBounds(left + margin.Left, top + margin.Top,
                                    width - margin.Left - margin.Right, child.Height);

                    int height2 = margin.Top + margin.Bottom + child.Height;
                    top += height2;
                    height -= height2;
                }

                if (0 != (dock.value & Pos.Left.value))
                {
                    GwenMargin margin = child.Margin;

                    child.SetBounds(left + margin.Left, top + margin.Top, child.Width,
                                      height - margin.Top - margin.Bottom);

                    int width2 = margin.Left + margin.Right + child.Width;
                    left += width2;
                    width -= width2;
                }
                
       

                if (0 != (dock.value & Pos.Right.value))
                {
                    // TODO: THIS MARGIN CODE MIGHT NOT BE FULLY FUNCTIONAL
                    GwenMargin margin = child.Margin;

                    child.SetBounds((left + width) - child.Width - margin.Right, top + margin.Top,
                                      child.Width, height - margin.Top - margin.Bottom);

                    int width3 = margin.Left + margin.Right + child.Width;
                    width -= width3;
                }

                if (0 != (dock.value & Pos.Bottom.value))
                {
                    // TODO: THIS MARGIN CODE MIGHT NOT BE FULLY FUNCTIONAL
                    GwenMargin margin = child.Margin;

                    child.SetBounds(left + margin.Left,
                                      (top + bounds.height) - child.Height - margin.Bottom,
                                      width - margin.Left - margin.Right, child.Height);
                    height -= child.Height + margin.Bottom + margin.Top;
                }

                child.RecurseLayout(skin);
            }

            m_InnerBounds = m_RenderBounds;

            //
            // Fill uses the left over space, so do that now.
            //
            for(GwenControlBase child in m_Children)
            {
                Pos dock = child.Dock;

                if (!(0 != (dock.value & Pos.Fill.value)))
                    continue;

                GwenMargin margin = child.Margin;

                child.SetBounds(left + margin.Left, top + margin.Top,
                                  width - margin.Left - margin.Right, bounds.height - margin.Top - margin.Bottom);
                child.RecurseLayout(skin);
            }

            PostLayout(skin);

            if (IsTabable)
            {
                if (GetCanvas()._firstTab == null)
                    GetCanvas()._firstTab = this;
                if (GetCanvas()._nextTab == null)
                    GetCanvas()._nextTab = this;
            }

            if (InputHandler.KeyboardFocus == this)
            {
                GetCanvas()._nextTab = null;
            }
        }

        /// <summary>
        /// Checks if the given control is a child of this instance.
        /// </summary>
        /// <param name="child">Control to examine.</param>
        /// <returns>True if the control is out child.</returns>
        bool IsChild(GwenControlBase child)
        {
            return m_Children.contains(child);
        }

        /// <summary>
        /// Converts local coordinates to canvas coordinates.
        /// </summary>
        /// <param name="pnt">Local coordinates.</param>
        /// <returns>Canvas coordinates.</returns>
        Point LocalPosToCanvas(Point pnt)
        {
            if (m_Parent != null)
            {
                int x = pnt.x + X;
                int y = pnt.y + Y;

                // If our parent has an innerpanel and we're a child of it
                // add its offset onto us.
                //
                if (m_Parent.m_InnerPanel != null && m_Parent.m_InnerPanel.IsChild(this))
                {
                    x += m_Parent.m_InnerPanel.X;
                    y += m_Parent.m_InnerPanel.Y;
                }

                return m_Parent.LocalPosToCanvas(new Point(x, y));
            }

            return pnt;
        }

        /// <summary>
        /// Converts canvas coordinates to local coordinates.
        /// </summary>
        /// <param name="pnt">Canvas coordinates.</param>
        /// <returns>Local coordinates.</returns>
        Point CanvasPosToLocal(Point pnt)
        {
            if (m_Parent != null)
            {
                int x = pnt.x - X;
                int y = pnt.y - Y;

                // If our parent has an innerpanel and we're a child of it
                // add its offset onto us.
                //
                if (m_Parent.m_InnerPanel != null && m_Parent.m_InnerPanel.IsChild(this))
                {
                    x -= m_Parent.m_InnerPanel.X;
                    y -= m_Parent.m_InnerPanel.Y;
                }


                return m_Parent.CanvasPosToLocal(new Point(x, y));
            }

            return pnt;
        }

        /// <summary>
        /// Closes all menus recursively.
        /// </summary>
        void CloseMenus()
        {
            //Debug.Print("Base.CloseMenus: {0}", this);

            // todo: not very efficient with the copying and recursive closing, maybe store currently open menus somewhere (canvas)?
            

            for(GwenControlBase child in m_Children)
            {
                if(child != null)
                child.CloseMenus();
            }
        }

        /// <summary>
        /// Copies Bounds to RenderBounds.
        /// </summary>
        void UpdateRenderBounds()
        {
          /*
            m_RenderBounds.x = 0;
            m_RenderBounds.y = 0;

            m_RenderBounds.Width = m_Bounds.width;
            m_RenderBounds.Height = m_Bounds.height;
            */
            m_RenderBounds = new Rectangle<int>(0, 0, m_Bounds.width, m_Bounds.height);
        }

        /// <summary>
        /// Sets mouse cursor to current cursor.
        /// </summary>
        void UpdateCursor()
        {
            //Neutral.SetCursor(m_Cursor);
           Skin.Renderer.SetCursor(m_Cursor);
        }

        // giver
        GwenPackage DragAndDrop_GetPackage(int x, int y)
        {
            return m_DragAndDrop_Package;
        }

        // giver
        bool DragAndDrop_Draggable()
        {
            if (m_DragAndDrop_Package == null)
                return false;

            return m_DragAndDrop_Package.IsDraggable;
        }

        // giver
        void DragAndDrop_SetPackage(bool draggable, [String name = "", Object userData = null])
        {
            if (m_DragAndDrop_Package == null)
            {
                m_DragAndDrop_Package = new GwenPackage();
                m_DragAndDrop_Package.IsDraggable = draggable;
                m_DragAndDrop_Package.Name = name;
                m_DragAndDrop_Package.UserData = userData;
            }
        }

        // giver
        bool DragAndDrop_ShouldStartDrag()
        {
            return true;
        }

        // giver
        void DragAndDrop_StartDragging(GwenPackage package, int x, int y)
        {
            package.HoldOffset = CanvasPosToLocal(new Point(x, y));
            package.DrawControl = this;
        }

        // giver
        void DragAndDrop_EndDragging(bool success, int x, int y)
        {
        }

        // receiver
        bool DragAndDrop_HandleDrop(GwenPackage p, int x, int y)
        {
          /// TODO: implement Drag and Drop
           // DragAndDrop.SourceControl.Parent = this;
            return true;
        }

        // receiver
        void DragAndDrop_HoverEnter(GwenPackage p, int x, int y)
        {

        }

        // receiver
        void DragAndDrop_HoverLeave(GwenPackage p)
        {

        }

        // receiver
        void DragAndDrop_Hover(GwenPackage p, int x, int y)
        {

        }

        // receiver
        bool DragAndDrop_CanAcceptPackage(GwenPackage p)
        {
            return false;
        }

        /// <summary>
        /// Resizes the control to fit its children.
        /// </summary>
        /// <param name="width">Determines whether to change control's width.</param>
        /// <param name="height">Determines whether to change control's height.</param>
        /// <returns>True if bounds changed.</returns>
        bool SizeToChildren([bool width = true, bool height = true])
        {
            Point size = GetChildrenSize();
            //size.x += Padding.Right;
            //size.y += Padding.Bottom;
            size = new Point<int>(Padding.Right, Padding.Bottom);
            return SetSize(width ? size.x : Width, height ? size.y : Height);
        }

        /// <summary>
        /// Returns the total width and height of all children.
        /// </summary>
        /// <remarks>Default implementation returns maximum size of children since the layout is unknown.
        /// Implement this in derived compound controls to properly return their size.</remarks>
        /// <returns></returns>
        Point GetChildrenSize()
        {
            Point size = new Point(0,0);

            for(GwenControlBase child in m_Children)
            {
                if (child.IsHidden)
                    continue;
                size = new Point<int> ( max(size.x, child.Right), max(size.y, child.Bottom));
                //size.x = Math.Max(size.x, child.Right);
                //size.y = Math.Max(size.y, child.Bottom);
            }

            return size;
        }

        /// <summary>
        /// Handles keyboard accelerator.
        /// </summary>
        /// <param name="accelerator">Accelerator text.</param>
        /// <returns>True if handled.</returns>
        bool HandleAccelerator(String accelerator)
        {
            if (InputHandler.KeyboardFocus == this || !AccelOnlyFocus)
            {
                if (m_Accelerators.containsKey(accelerator))
                {
          m_Accelerators[accelerator].Invoke(this, GwenEventArgs.Empty);
                    return true;
                }
            }
            if(m_Children.length > 0)
            {
              return m_Children[0].HandleAccelerator(accelerator);
            }
            return false;

        }

        /// <summary>
        /// Adds keyboard accelerator.
        /// </summary>
        /// <param name="accelerator">Accelerator text.</param>
        /// <param name="handler">Handler.</param>
        void AddAccelerator(String accelerator, GwenEventHandler handler)
        {
            accelerator = accelerator.trim().toUpperCase();
            m_Accelerators[accelerator] = handler;
        }

        /// <summary>
        /// Adds keyboard accelerator with a default handler.
        /// </summary>
        /// <param name="accelerator">Accelerator text.</param>
        void AddAcceleratorWithDefaultHandler(String accelerator)
        {
            m_Accelerators[accelerator] = new AcceleratorEventHandler(DefaultAcceleratorHandler);
        }

        /// <summary>
        /// Function invoked after layout.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void PostLayout(GwenSkinBase skin)
        {

        }

        /// <summary>
        /// Re-renders the control, invalidates cached texture.
        /// </summary>
        void Redraw()
        {
            UpdateColors();
            m_CacheTextureDirty = true;
            if (m_Parent != null)
                m_Parent.Redraw();
        }

        /// <summary>
        /// Updates control colors.
        /// </summary>
        /// <remarks>
        /// Used in composite controls like lists to differentiate row colors etc.
        /// </remarks>
        void UpdateColors()
        {

        }

        /// <summary>
        /// Invalidates control's parent.
        /// </summary>
        void InvalidateParent()
        {
            if (m_Parent != null)
            {
                m_Parent.Invalidate();
            }
        }

        /// <summary>
        /// Handler for keyboard events.
        /// </summary>
        /// <param name="key">Key pressed.</param>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyPressed(GwenKey key, [bool down = true])
        {
            bool handled = false;
            switch (key)
            {
                case GwenKey.Tab: handled = OnKeyTab(down); break;
                case GwenKey.Space: handled = OnKeySpace(down); break;
                case GwenKey.Home: handled = OnKeyHome(down); break;
                case GwenKey.End: handled = OnKeyEnd(down); break;
                case GwenKey.Return: handled = OnKeyReturn(down); break;
                case GwenKey.Backspace: handled = OnKeyBackspace(down); break;
                case GwenKey.Delete: handled = OnKeyDelete(down); break;
                case GwenKey.Right: handled = OnKeyRight(down); break;
                case GwenKey.Left: handled = OnKeyLeft(down); break;
                case GwenKey.Up: handled = OnKeyUp(down); break;
                case GwenKey.Down: handled = OnKeyDown(down); break;
                case GwenKey.Escape: handled = OnKeyEscape(down); break;
                default: break;
            }

            if (!handled && Parent != null)
                Parent.OnKeyPressed(key, down);

            return handled;
        }

        /// <summary>
        /// Invokes key press event (used by input system).
        /// </summary>
        bool InputKeyPressed(GwenKey key, [bool down = true])
        {
            return OnKeyPressed(key, down);
        }

        /// <summary>
        /// Handler for keyboard events.
        /// </summary>
        /// <param name="key">Key pressed.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyReleaseed(GwenKey key)
        {
            return OnKeyPressed(key, false);
        }

        /// <summary>
        /// Handler for Tab keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyTab(bool down)
        {
            if (!down)
                return true;

            if (GetCanvas()._nextTab != null)
            {
                GetCanvas()._nextTab.Focus();
                Redraw();
            }

            return true;
        }

        /// <summary>
        /// Handler for Space keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeySpace(bool down) { return false; }

        /// <summary>
        /// Handler for Return keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyReturn(bool down) { return false; }

        /// <summary>
        /// Handler for Backspace keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyBackspace(bool down) { return false; }

        /// <summary>
        /// Handler for Delete keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyDelete(bool down) { return false; }

        /// <summary>
        /// Handler for Right Arrow keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyRight(bool down) { return false; }

        /// <summary>
        /// Handler for Left Arrow keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyLeft(bool down) { return false; }

        /// <summary>
        /// Handler for Home keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyHome(bool down) { return false; }

        /// <summary>
        /// Handler for End keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyEnd(bool down) { return false; }

        /// <summary>
        /// Handler for Up Arrow keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyUp(bool down) { return false; }

        /// <summary>
        /// Handler for Down Arrow keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyDown(bool down) { return false; }

        /// <summary>
        /// Handler for Escape keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>True if handled.</returns>
        bool OnKeyEscape(bool down) { return false; }

        /// <summary>
        /// Handler for Paste event.
        /// </summary>
        /// <param name="from">Source control.</param>
        void OnPaste(GwenControlBase from, GwenEventArgs args)
        {
        }

        /// <summary>
        /// Handler for Copy event.
        /// </summary>
        /// <param name="from">Source control.</param>
        void OnCopy(GwenControlBase from, GwenEventArgs args)
        {
        }

        /// <summary>
        /// Handler for Cut event.
        /// </summary>
        /// <param name="from">Source control.</param>
    void OnCut(GwenControlBase from, GwenEventArgs args)
        {
        }

        /// <summary>
        /// Handler for Select All event.
        /// </summary>
        /// <param name="from">Source control.</param>
    void OnSelectAll(GwenControlBase from, GwenEventArgs args)
        {
        }

        void InputCopy(GwenControlBase from)
        {
            OnCopy(from, GwenEventArgs.Empty);
        }

        void InputPaste(GwenControlBase from)
        {
      OnPaste(from, GwenEventArgs.Empty);
        }

        void InputCut(GwenControlBase from)
        {
      OnCut(from, GwenEventArgs.Empty);
        }

        void InputSelectAll(GwenControlBase from)
        {
      OnSelectAll(from, GwenEventArgs.Empty);
        }

        /// <summary>
        /// Renders the focus overlay.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void RenderFocus(GwenSkinBase skin)
        {
            if (InputHandler.KeyboardFocus != this)
                return;
            if (!IsTabable)
                return;

            skin.DrawKeyboardHighlight(this, RenderBounds, 3);
        }

        /// <summary>
        /// Renders under the actual control (shadows etc).
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void RenderUnder(GwenSkinBase skin)
        {

        }

        /// <summary>
        /// Renders over the actual control (overlays).
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void RenderOver(GwenSkinBase skin)
        {

        }

        /// <summary>
        /// Called during rendering.
        /// </summary>
        void Think()
        {

        }

        /// <summary>
        /// Handler for gaining keyboard focus.
        /// </summary>
        void OnKeyboardFocus()
        {

        }

        /// <summary>
        /// Handler for losing keyboard focus.
        /// </summary>
        void OnLostKeyboardFocus()
        {

        }

        /// <summary>
        /// Handler for character input event.
        /// </summary>
        /// <param name="chr">Character typed.</param>
        /// <returns>True if handled.</returns>
        bool OnChar(String chr)
        {
            return false;
        }

        bool InputChar(String chr)
        {
            return OnChar(chr);
        }

        void Anim_WidthIn(double length, [double delay = 0.0, double ease = 1.0])
        {
            /// TODO: Implement animation
            //Animation.Add(this, new Anim.Size.Width(0, Width, length, false, delay, ease));
            Width = 0;
        }

        void Anim_HeightIn(double length, double delay, double ease)
        {
/// TODO: Implement animation
          // Animation.Add(this, new Anim.Size.Height(0, Height, length, false, delay, ease));
            Height = 0;
        }

        void Anim_WidthOut(double length, bool hide, double delay, double ease)
        {
/// TODO: Implement animation
          //Animation.Add(this, new Anim.Size.Width(Width, 0, length, hide, delay, ease));
        }

        void Anim_HeightOut(double length, bool hide, double delay, double ease)
        {
/// TODO: Implement animation
          //Animation.Add(this, new Anim.Size.Height(Height, 0, length, hide, delay, ease));
        }

        void FitChildrenToSize()
        {
            for(GwenControlBase child in Children)
            {
                //push them back into view if they are outside it
                child.X = min(Bounds.width, child.X + child.Width) - child.Width;
                child.Y = min(Bounds.height, child.Y + child.Height) - child.Height;

                //Non-negative has priority, so do it second.
                child.X = max(0, child.X);
                child.Y = max(0, child.Y);
            }
        }
  
}
