part of gwendart;


class GwenComboBoxEventHandler extends GwenEventHandler
{
  final ComboBox _comboBox;
  
  GwenComboBoxEventHandler(ComboBox comboBox) : _comboBox = comboBox
      {
    
      }
  
  void Invoke(GwenControlBase control, GwenEventArgs args)
  {
    _comboBox.OnItemSelected(control, args);
  }
}


class ComboBox extends Button
{
    Menu _menu;
    GwenControlBase _button;
    MenuItem _selectedItem;
    
    GwenEventHandlerList ItemSelected = new GwenEventHandlerList();
    
    bool get IsOpen => (_menu == null) ? false : !_menu.IsHidden;
    
    ComboBox(GwenControlBase parent) : super(parent)
    {
      SetSize(100, 20);
      _menu = new Menu(this);
      _menu.IsHidden=true;
      _menu.IconMarginDisabled =true;
      _menu.IsTabable = false;
      
      DownArrow arrow = new DownArrow(this);
      _button = arrow;
      
      Alignment = new Pos(Pos.Left.value | Pos.CenterV.value);
      this.Text = "";
      Margin = new GwenMargin(3, 0, 0, 0);
      
      IsTabable = true;
      KeyboardInputEnabled = true;
      
    }
    

        /// <summary>
        /// Selected item.
        /// </summary>
        /// <remarks>Not just String property, because items also have names.</remarks>
        MenuItem get SelectedItem
        { return _selectedItem; }
        set SelectedItem (MenuItem value)
        {
                if (value != null && value.Parent == _menu)
                {
                    _selectedItem = value;
                    OnItemSelected(_selectedItem, new ItemSelectedEventArgs(value));
                }
        }

        bool get IsMenuComponent
        {
             return true; 
        }

        /// <summary>
        /// Adds a new item.
        /// </summary>
        /// <param name="label">Item label (displayed).</param>
        /// <param name="name">Item name.</param>
        /// <returns>Newly created control.</returns>
        MenuItem AddItem(String label, [String name = "", Object UserData = null] )
        {
            MenuItem item = _menu.AddItem(label, "");
            item.Name = name;
            item.Selected.add(new GwenComboBoxEventHandler(this));
            item.UserData = UserData;

            if (_selectedItem == null)
                OnItemSelected(item, new ItemSelectedEventArgs(null));

            return item;
        }

        /// <summary>
        /// Renders the control using specified skin.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void Render(GwenSkinBase skin)
        {
            skin.DrawComboBox(this, IsDepressed, IsOpen);
        }

        void Disable()
        {
            super.Disable();
            GetCanvas().CloseMenus();
        }

        /// <summary>
        /// Internal Pressed implementation.
        /// </summary>
        void OnClicked(int x, int y)
        {
            if (IsOpen)
            {
                GetCanvas().CloseMenus();
                return;
            }

            bool wasMenuHidden = _menu.IsHidden;

            GetCanvas().CloseMenus();

            if (wasMenuHidden)
            {
                Open();
            }

      super.OnClicked(x, y);
        }

        /// <summary>
        /// Removes all items.
        /// </summary>
        void DeleteAll()
        {
            if (_menu != null)
                _menu.DeleteAll();
        }

        /// <summary>
        /// Internal handler for item selected event.
        /// </summary>
        /// <param name="control">Event source.</param>
    void OnItemSelected(GwenControlBase control, ItemSelectedEventArgs args)
        {
            if (!IsDisabled)
            {
                //Convert selected to a menu item
                MenuItem item = control as MenuItem;
                if (null == item) return;

                _selectedItem = item;
                this.Text = _selectedItem.Text;
                _menu.IsHidden = true;

                if (ItemSelected != null)
                    ItemSelected.Invoke(this, args);

                Focus();
                Invalidate();
            }
        }

        /// <summary>
        /// Lays out the control's interior according to alignment, padding, dock etc.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void Layout(GwenSkinBase skin)
        {
            _button.Position(new Pos(Pos.Right.value | Pos.CenterV.value), 4, 0);
            super.Layout(skin);
        }

        /// <summary>
        /// Handler for losing keyboard focus.
        /// </summary>
        void OnLostKeyboardFocus()
        {
            TextColor = Color.Black;
        }

        /// <summary>
        /// Handler for gaining keyboard focus.
        /// </summary>
        void OnKeyboardFocus()
        {
            //Until we add the blue highlighting again
            TextColor = Color.Black;
        }

        /// <summary>
        /// Opens the combo.
        /// </summary>
        void Open()
        {
            if (!IsDisabled)
            {
                if (null == _menu) return;

                _menu.Parent = GetCanvas();
                _menu.IsHidden = false;
                _menu.BringToFront();

                Point p = LocalPosToCanvas(new Point(0,0));

                _menu.SetBoundsRect(new Rectangle(p.x, p.y + Height, Width, _menu.Height));
            }
        }

        /// <summary>
        /// Closes the combo.
        /// </summary>
        void Close()
        {
            if (_menu == null)
                return;

            _menu.Hide();
        }

        /// <summary>
        /// Handler for Down Arrow keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>
        /// True if handled.
        /// </returns>
        bool OnKeyDown(bool down)
        {
            if (down)
            {
               bool bFoundOne=false;
               for( GwenControlBase child in _menu.Children)
               {
                 if(null != child)
                 {
                   if(child is MenuItem)
                   {
                     MenuItem item = child;
                     if(!bFoundOne)
                     {
                        if(item == _selectedItem)
                        {
                          bFoundOne=true;
                        }
                     } else
                     {
                       OnItemSelected(this, new ItemSelectedEventArgs(item));
                       break;
                     }
                   }
                 }
               }
               // var it = _menu.Children.FindIndex(x => x == _selectedItem);
               // if (it + 1 < _menu.Children.Count)
               //     OnItemSelected(this, new ItemSelectedEventArgs(_menu.Children[it + 1]));
            }
            return true;
        }

        /// <summary>
        /// Handler for Up Arrow keyboard event.
        /// </summary>
        /// <param name="down">Indicates whether the key was pressed or released.</param>
        /// <returns>
        /// True if handled.
        /// </returns>
        bool OnKeyUp(bool down)
        {
            if (down)
            {
              MenuItem prevItem=null;
              for( GwenControlBase child in _menu.Children)
              {
                if(null != child)
                {
                  if(child is MenuItem)
                  {
                    MenuItem item = child;
                    if(null == prevItem)
                    {
                      if(item == _selectedItem)
                      {
                        prevItem = item;
                      }
                    } else
                    {
                      OnItemSelected(this, new ItemSelectedEventArgs(prevItem));
                      break;
                    }
                  }
                }
              }
               // var it = _menu.Children.FindLastIndex(x => x == _selectedItem);
               // if (it - 1 >= 0)
               //     OnItemSelected(this, new ItemSelectedEventArgs(_menu.Children[it - 1]));
            }
            return true;
        }

        /// <summary>
        /// Renders the focus overlay.
        /// </summary>
        /// <param name="skin">Skin to use.</param>
        void RenderFocus(GwenSkinBase skin)
        {

        }

        /// <summary>
        /// Selects the first menu item with the given text it finds. 
        /// If a menu item can not be found that matches input, nothing happens.
        /// </summary>
        /// <param name="label">The label to look for, this is what is shown to the user.</param>
        void SelectByText(String text)
        {
            for (MenuItem item in _menu.Children)
            {
                if (item.Text == text)
                {
                    SelectedItem = item;
                    return;
                }
            }
        }

        /// <summary>
        /// Selects the first menu item with the given name it finds.
        /// If a menu item can not be found that matches input, nothing happens.
        /// </summary>
        /// <param name="name">The name to look for. To select by what is displayed to the user, use "SelectByText".</param>
        void SelectByName(String name)
        {
            for (MenuItem item in _menu.Children)
            {
                if (item.Name == name)
                {
                    SelectedItem = item;
                    return;
                }
            }
        }

        /// <summary>
        /// Selects the first menu item with the given user data it finds.
        /// If a menu item can not be found that matches input, nothing happens.
        /// </summary>
        /// <param name="userdata">The UserData to look for. The equivalency check uses "param.Equals(item.UserData)".
        /// If null is passed in, it will look for null/unset UserData.</param>
        void SelectByUserData(Object userdata)
        {
            for (MenuItem item in _menu.Children)
            {
                if (userdata == null)
                {
                    if (item.UserData == null)
                    {
                        SelectedItem = item;
                        return;
                    }
                }
                else if (userdata == item.UserData)
                {
                    SelectedItem = item;
                    return;
                }
            }
        }
}