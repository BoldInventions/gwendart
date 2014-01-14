part of gwendart;

class MenuItem extends Button
{
   bool _onStrip;
   bool _checkable;
   bool _checked;
   Menu _menu;
   GwenControlBase _subMenuArrow;
   Label _accelerator;
   
   
   bool get IsOnStrip => _onStrip;
   set IsOnStrip(bool value) { _onStrip=value; }
   
   bool get IsCheckable => _checkable;
   set IsCheckable (bool value) { _checkable = value; }
   
   bool get IsMenuOpen => (_menu==null) ? false : !_menu.IsHidden;
   
   bool get IsChecked => _checked;
   set IsChecked(bool value)
   {
     if(value == _checked) return;
     _checked = value;
     CheckChanged.Invoke(this, GwenEventArgs.Empty);
     if(value)
     {
       Checked.Invoke(this, GwenEventArgs.Empty);
     } else
     {
       UnChecked.Invoke(this, GwenEventArgs.Empty);
     }
   }
   
   Menu get MyMenu
   {
     if(null == _menu)
     {
       _menu = new Menu(GetCanvas());
       _menu.IsHidden=true;
       if(!_onStrip)
       {
         _subMenuArrow = new RightArrow(this);
         _subMenuArrow.SetSize(15, 15);
       }
       Invalidate();
     }
     return _menu;
   }
   
   GwenEventHandlerList Selected = new GwenEventHandlerList();
   GwenEventHandlerList Checked = new GwenEventHandlerList();
   GwenEventHandlerList UnChecked = new GwenEventHandlerList();
   GwenEventHandlerList CheckChanged = new GwenEventHandlerList();
   
   MenuItem(GwenControlBase parent) : super(parent)
   {
     _onStrip=false;
     IsTabable = false;
     IsCheckable = false;
     IsChecked = false;
     _accelerator = new Label(this);
   }
   
   

   /// <summary>
   /// Renders the control using specified skin.
   /// </summary>
   /// <param name="skin">Skin to use.</param>
   void Render(GwenSkinBase skin)
   {
     skin.DrawMenuItem(this, IsMenuOpen, _checkable ? _checked : false);
   }

   /// <summary>
   /// Lays out the control's interior according to alignment, padding, dock etc.
   /// </summary>
   /// <param name="skin">Skin to use.</param>
   void Layout(GwenSkinBase skin)
   {
     if (_subMenuArrow != null)
     {
       _subMenuArrow.Position(Pos.Right | Pos.CenterV, 4, 0);
     }
     super.Layout(skin);
   }

   /// <summary>
   /// Internal OnPressed implementation.
   /// </summary>
   void OnClicked(int x, int y)
   {
     if (_menu != null)
     {
       ToggleMenu();
     }
     else if (!_onStrip)
     {
       IsChecked = !IsChecked;
       if (Selected != null)
         Selected.Invoke(this, new ItemSelectedEventArgs(this));
       GetCanvas().CloseMenus();
     }
     super.OnClicked(x, y);
   }

   /// <summary>
   /// Toggles the menu open state.
   /// </summary>
   void ToggleMenu()
   {
     if (IsMenuOpen)
       CloseMenu();
     else
       OpenMenu();
   }

   /// <summary>
   /// Opens the menu.
   /// </summary>
   void OpenMenu()
   {
     if (null == _menu) return;

     _menu.IsHidden = false;
     _menu.BringToFront();

     Point p = LocalPosToCanvas(new Point(0, 0));

     // Strip menus open downwards
     if (_onStrip)
     {
       _menu.SetPosition(p.x, p.y + Height + 1);
     }
     // Submenus open sidewards
     else
     {
       _menu.SetPosition(p.x + Width, p.y);
     }

     // TODO: Option this.
     // TODO: Make sure on screen, open the other side of the 
     // parent if it's better...
   }

   /// <summary>
   /// Closes the menu.
   /// </summary>
   void CloseMenu()
   {
     if (null == _menu) return;
     _menu.Close();
     _menu.CloseAll();
   }

   void SizeToContents()
   {
     super.SizeToContents();
     if (_accelerator != null)
     {
       _accelerator.SizeToContents();
       Width = Width + _accelerator.Width;
     }
   }

   MenuItem SetAction(GwenEventHandler handler)
   {
     if (_accelerator != null)
     {
       AddAccelerator(_accelerator.Text, handler);
     }

     Selected += handler;
     return this;
   }

   void SetAccelerator(String acc)
   {
     if (_accelerator != null)
     {
       //_accelerator.DelayedDelete(); // to prevent double disposing
       _accelerator = null;
     }

     if (acc == "")
       return;

     _accelerator = new Label(this);
     _accelerator.Dock = Pos.Right;
     _accelerator.Alignment = Pos.Right | Pos.CenterV;
     _accelerator.Text = acc;
     _accelerator.Margin = new GwenMargin(0, 0, 16, 0);
     // todo
   }
   
   
}