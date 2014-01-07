part of gwendart;

class TabControlScrollPressedEventHandler extends GwenEventHandler
{
  final Pos _direction;
  final TabControl _tabControl;
  
  TabControlScrollPressedEventHandler(Pos direction, TabControl tabControl) : _direction  = direction, _tabControl = tabControl
  {
    
  }
  
  void Invoke(GwenControlBase control, GwenEventArgs args)
  {
     switch(_direction)
     {
       case Pos.Left:
         _tabControl.ScrollPressedLeft(control, args);
         break;
       case Pos.Right:
         _tabControl.ScrollPressedRight(control, args);
         break;
       default:
         throw new StateError("TabControlScrollPressedEventHandler cannot accept any Pos but left and right");
     }
  }
}

class TabControlOnTabHandler extends GwenEventHandler
{
   static const int ON_PRESSED=1;
   static const int ON_LOSE_TAB =2;
   
   final int _selector;
   final TabControl _tabControl;
   
   TabControlOnTabHandler(int selector, TabControl tabControl) : _selector = selector, _tabControl=tabControl
   {
     
   }
   
   void Invoke(GwenControlBase control, GwenEventArgs args)
   {
     switch(_selector)
     {
       case ON_PRESSED:
         _tabControl.OnTabPressed(control, args);
         break;

       default:
         throw new StateError("TabeControlOnTabHandler cannot have any _selector but 0 or ");
     }
   }
}

class TabControl extends GwenControlBase
{
   TabStrip _TabStrip;
   List<ScrollBarButton> _scroll;
   TabButton _CurrentButton;
   int _ScrollOffset;
   TabControlOnTabHandler _onTabPressedHandler;
   
   GwenEventHandlerList TabAdded=new GwenEventHandlerList();
   
   GwenEventHandlerList TabRemoved = new GwenEventHandlerList();
   
   bool get AllowReorder => _TabStrip.AllowReorder;
   set AllowReorder (bool value)
   {
     _TabStrip.AllowReorder = value;
   }
   
   TabButton get CurrentButton => _CurrentButton;
   
   Pos get TabStripPosition => _TabStrip.StripPosition;
   set TabStripPosition (Pos value)
   {
     _TabStrip.StripPosition = value;
   }
   
   TabControl(GwenControlBase parent) : super(parent)
   {
     TabControlScrollPressedEventHandler pressHandlerLeft = new TabControlScrollPressedEventHandler(Pos.Left, this);
     TabControlScrollPressedEventHandler pressHandlerRight = new TabControlScrollPressedEventHandler(Pos.Right, this);
     _scroll = new List<ScrollBarButton>();
     _ScrollOffset = 0;
     
     _TabStrip = new TabStrip(this);
     _TabStrip.StripPosition = Pos.Top;
     
     _scroll[0] = new ScrollBarButton(this);
     _scroll[0].SetDirectionLeft();
     _scroll[0].Clicked.add(pressHandlerLeft);
     _scroll[0].SetSize(14, 16);
     
     _scroll[1] = new ScrollBarButton(this);
     _scroll[1].SetDirectionRight();
     _scroll[1].Clicked.add(pressHandlerRight);
     _scroll[1].SetSize(14, 16);
     
     m_InnerPanel = new TabControlInner._internal(this);
     m_InnerPanel.Dock = Pos.Fill;
     m_InnerPanel.SendToBack();
     IsTabable = false;
   }
   

        /// <summary>
        /// Adds a new page/tab.
        /// </summary>
        /// <param name="label">Tab label.</param>
        /// <param name="page">Page contents.</param>
        /// <returns>Newly created control.</returns>
        TabButton AddPage(String label,[ GwenControlBase page = null])
        {
            if (null == page)
            {
                page = new GwenControlBase(this);
            }
            else
            {
                page.Parent = this;
            }

            TabButton button = new TabButton(_TabStrip);
            button.SetText(label);
            button.Page = page;
            button.IsTabable = false;

            AddPageButton(button);
            return button;
        }

        /// <summary>
        /// Adds a page/tab.
        /// </summary>
        /// <param name="button">Page to add. (well, it's a TabButton which is a parent to the page).</param>
        void AddPageButton(TabButton button)
        {
            GwenControlBase page = button.Page;
            page.Parent = this;
            page.IsHidden = true;
            page.Margin = new GwenMargin(6, 6, 6, 6);
            page.Dock = Pos.Fill;

            button.Parent = _TabStrip;
            button.Dock = Pos.Left;
            button.SizeToContents();
            if (button.MyTabControl != null)
                button.MyTabControl.UnsubscribeTabEvent(button);
            button.MyTabControl = this;
            _onTabPressedHandler=new TabControlOnTabHandler(TabControlOnTabHandler.ON_PRESSED, this);
            button.Clicked.add(_onTabPressedHandler);

            if (null == _CurrentButton)
            {
                button.Press();
            }

            if (TabAdded != null)
                TabAdded.Invoke(this, GwenEventArgs.Empty);

            Invalidate();
        }

        void UnsubscribeTabEvent(TabButton button)
        {
            button.Clicked.remove(_onTabPressedHandler);
        }

        /// <summary>
        /// Handler for tab selection.
        /// </summary>
        /// <param name="control">Event source (TabButton).</param>
    void OnTabPressed(GwenControlBase control, GwenEventArgs args)
        {
            TabButton button = control as TabButton;
            if (null == button) return;

            GwenControlBase page = button.Page;
            if (null == page) return;

            if (_CurrentButton == button)
                return;

            if (null != _CurrentButton)
            {
                GwenControlBase page2 = _CurrentButton.Page;
                if (page2 != null)
                {
                    page2.IsHidden = true;
                }
                _CurrentButton.Redraw();
                _CurrentButton = null;
            }

            _CurrentButton = button;

            page.IsHidden = false;

            _TabStrip.Invalidate();
            Invalidate();
        }

        /// <summary>
        /// Function invoked after layout.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void PostLayout(GwenSkinBase skin)
        {
            super.PostLayout(skin);
            HandleOverflow();
        }

        /// <summary>
        /// Handler for tab removing.
        /// </summary>
        /// <param name="button"></param>
        void OnLoseTab(TabButton button)
        {
            if (_CurrentButton == button)
                _CurrentButton = null;

            //TODO: Select a tab if any exist.

            if (TabRemoved != null)
        TabRemoved.Invoke(this, GwenEventArgs.Empty);

            Invalidate();
        }

        /// <summary>
        /// Number of tabs in the control.
        /// </summary>
        int get TabCount  => _TabStrip.Children.length;

        void HandleOverflow()
        {
            Point TabsSize = _TabStrip.GetChildrenSize();

            // Only enable the scrollers if the tabs are at the top.
            // This is a limitation we should explore.
            // Really TabControl should have derivitives for tabs placed elsewhere where we could specialize 
            // some functions like this for each direction.
            bool needed = TabsSize.x > Width && _TabStrip.Dock == Pos.Top;

            _scroll[0].IsHidden = !needed;
            _scroll[1].IsHidden = !needed;

            if (!needed) return;

            _ScrollOffset = GwenUtil.Clamp(_ScrollOffset, 0, TabsSize.x - Width + 32);


            _TabStrip.Margin = new GwenMargin(_ScrollOffset*-1, 0, 0, 0);


            _scroll[0].SetPosition(Width - 30, 5);
            _scroll[1].SetPosition(_scroll[0].Right, 5);
        }

   
   void ScrollPressedLeft(GwenControlBase control, GwenEventArgs args)
   {
     _ScrollOffset -= 120;
   }

   void ScrollPressedRight(GwenControlBase control, GwenEventArgs args)
   {
     _ScrollOffset += 120;
   }
   
   
   
}