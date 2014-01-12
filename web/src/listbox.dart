part of gwendart;

class GwenListBoxEventHandler extends GwenEventHandler
{
  static const int TABLE_RESIZED=0;
  static const int ROW_SELECTED=1;
  
   final ListBox _listBox;
   final int _code;
   GwenListBoxEventHandler(ListBox listBox, int code) : _listBox=listBox, _code=code
       {
     
       }
   
   void Invoke(GwenControlBase control, GwenEventArgs args)
   {
     switch(_code)
     {
       case TABLE_RESIZED:
         _listBox.TableResized(control, args);
         break;
       case ROW_SELECTED:
         _listBox.OnRowSelected(control, args);
         break;
       default:
         break;
     }

   }
}

class ListBox extends ScrollControl
{
   GwenTable _table;
   List<ListBoxRow> _selectedRows;
   bool _multiSelect;
   bool _sizeToContents;
   bool _isToggle;
   Pos _oldDock;
   
   bool get AllowMultiSelect => _multiSelect;
   set AllowMultiSelect (bool value)
   {
     _multiSelect = value;
     if(value)
     {
       _isToggle=true;
     }
   }
   
   int get RowCount => _table.RowCount;
   bool get IsToggle => _isToggle;
   set IsToggle(bool value) { _isToggle = value; }
   ListBoxRow GetRow(int index) { return _table.getRow(index); }
   
   List<TableRow> get SelectedRows => _selectedRows;
   
   ListBoxRow get SelectedRow => (0==_selectedRows.length)? null : _selectedRows[0];
   set SelectedRow (ListBoxRow value)
   {
      if(_table.Children.contains(value))
      {
        if(_multiSelect)
        {
           SelectRowByRow(value, false);
        } else
        {
          SelectRowByRow(value, true);
        }
      }
   }
   
   int get SelectedRowIndex => (null==SelectedRow) ? -1 : (_table.GetRowIndex(SelectedRow));
   set SelectedRowIndex (int value)
   {
     SelectRow(value);
   }
   
   int get ColumnCount => _table.ColumnCount;
   set ColumnCount (int value) { _table.ColumnCount = value; Invalidate(); }
   
   GwenEventHandlerList RowSelected = new GwenEventHandlerList();
   GwenEventHandlerList RowUnselected = new GwenEventHandlerList();
   
   ListBox(GwenControlBase parent) : super(parent)
   {
      _selectedRows = new List<ListBoxRow>();
      MouseInputEnabled = true;
      EnableScroll(false, true);
      AutoHideBars = true;
      Margin = GwenMargin.One;
      
      _table = new GwenTable(this);
      _table.Dock = Pos.Fill;
      _table.ColumnCount = 1;
      _table.BoundsChanged.add(new GwenListBoxEventHandler(this, GwenListBoxEventHandler.TABLE_RESIZED));
      _multiSelect = false;
      _isToggle = false;
      _sizeToContents = false;
      _oldDock = Pos.Fill;
   }
   
   

   /// <summary>
   /// Selects the specified row by index.
   /// </summary>
   /// <param name="index">Row to select.</param>
   /// <param name="clearOthers">Determines whether to deselect previously selected rows.</param>
   void SelectRow(int index, [bool clearOthers = false])
   {
     if (index < 0 || index >= _table.RowCount)
       return;

     SelectRowByRow(_table.Children[index], clearOthers);
   }

   /// <summary>
   /// Selects the specified row(s) by text.
   /// </summary>
   /// <param name="rowText">Text to search for (exact match).</param>
   /// <param name="clearOthers">Determines whether to deselect previously selected rows.</param>
   void SelectRows(String rowText, [bool clearOthers = false])
   {
     for(GwenControlBase child in Children)
     {
        if(child is ListBoxRow)
        {
           ListBoxRow lbr = child;
           if(lbr.Text == rowText)
           {
               if(lbr.Text == rowText)
               {
                  SelectRowByRow(lbr, clearOthers);
               }
           }
        }
     }
    //var rows = _table.Children.OfType<ListBoxRow>().Where(x => x.Text == rowText);
    // for(ListBoxRow row in rows)
    // {
    //   SelectRow(row, clearOthers);
    // }
   }



   /// <summary>
   /// Slelects the specified row.
   /// </summary>
   /// <param name="control">Row to select.</param>
   /// <param name="clearOthers">Determines whether to deselect previously selected rows.</param>
   void SelectRowByRow(GwenControlBase control, [bool clearOthers = false])
   {
     if (!AllowMultiSelect || clearOthers)
       UnselectAll();

     ListBoxRow row = control as ListBoxRow;
     if (row == null)
       return;

     // TODO: make sure this is one of our rows!
     row.IsSelected = true;
     _selectedRows.add(row);
     if (RowSelected != null)
       RowSelected.Invoke(this, new ItemSelectedEventArgs(row));
   }

   /// <summary>
   /// Removes the all rows from the ListBox
   /// </summary>
   /// <param name="idx">Row index.</param>
   void RemoveAllRows()
   {
     _table.DeleteAllChildren();
   }

   /// <summary>
   /// Removes the specified row by index.
   /// </summary>
   /// <param name="idx">Row index.</param>
   void RemoveRow(int idx)
   {
     _table.RemoveRowIndex(idx); // this calls Dispose()
   }

   /// <summary>
   /// Adds a new row.
   /// </summary>
   /// <param name="label">Row text.</param>
   /// <returns>Newly created control.</returns>
   ListBoxRow AddRowString(String label, [String name=""])
   {
     return AddRowUserData(label, name);
   }



   /// <summary>
   /// Adds a new row.
   /// </summary>
   /// <param name="label">Row text.</param>
   /// <param name="name">Internal control name.</param>
   /// <param name="UserData">User data for newly created row</param>
   /// <returns>Newly created control.</returns>
   ListBoxRow AddRowUserData(String label, String name, [Object UserData=null])
   {
     ListBoxRow row = new ListBoxRow(this);
     _table.AddRowRow(row);

     row.SetCellText(0, label);
     row.Name = name;
     row.UserData = UserData;

     row.Selected.add(new GwenListBoxEventHandler(this, GwenListBoxEventHandler.ROW_SELECTED));

     _table.SizeToContents(Width);

     return row;
   }

   /// <summary>
   /// Sets the column width (in pixels).
   /// </summary>
   /// <param name="column">Column index.</param>
   /// <param name="width">Column width.</param>
   void SetColumnWidth(int column, int width)
   {
     _table.SetColumnWidth(column, width);
     Invalidate();
   }

   /// <summary>
   /// Renders the control using specified skin.
   /// </summary>
   /// <param name="skin">Skin to use.</param>
   void Render(GwenSkinBase skin)
   {
     skin.DrawListBox(this);
   }

   /// <summary>
   /// Deselects all rows.
   /// </summary>
   void UnselectAll()
   {
     for(ListBoxRow row in _selectedRows)
     {
       row.IsSelected = false;
       if (RowUnselected != null)
         RowUnselected.Invoke(this, new ItemSelectedEventArgs(row));
     }
     _selectedRows.clear();
   }

   /// <summary>
   /// Unselects the specified row.
   /// </summary>
   /// <param name="row">Row to unselect.</param>
   void UnselectRow(ListBoxRow row)
   {
     row.IsSelected = false;
     _selectedRows.remove(row);

     if (RowUnselected != null)
       RowUnselected.Invoke(this, new ItemSelectedEventArgs(row));
   }

   /// <summary>
   /// Handler for the row selection event.
   /// </summary>
   /// <param name="control">Event source.</param>
   void OnRowSelected(GwenControlBase control, ItemSelectedEventArgs args)
   {
     // [omeg] changed default behavior
     bool clear = false;// !InputHandler.InputHandler.IsShiftDown;
     ListBoxRow row = args.SelectedItem as ListBoxRow;
     if (row == null)
       return;

     if (row.IsSelected)
     {
       if (IsToggle)
         UnselectRow(row);
     }
     else
     {
       SelectRowByRow(row, clear);
     }
   }

   /// <summary>
   /// Removes all rows.
   /// </summary>
   void Clear()
   {
     UnselectAll();
     _table.RemoveAll();
   }

   void SizeToContents()
   {
     _sizeToContents = true;
     // docking interferes with autosizing so we disable it until sizing is done
     _oldDock = _table.Dock;
     _table.Dock = Pos.None;
     _table.SizeToContents(0); // autosize without constraints
   }

   void TableResized(GwenControlBase control,GwenEventArgs args)
   {
     if (_sizeToContents)
     {
        if( (_table.Width != m_Bounds.width)|| (_table.Height != m_Bounds.height) )
        {
          SetSize(_table.Width, _table.Height);
          _sizeToContents = false;
          _table.Dock = _oldDock;
          Invalidate();
        }
     }
   }

   /// <summary>
   /// Selects the first menu item with the given text it finds. 
   /// If a menu item can not be found that matches input, nothing happens.
   /// </summary>
   /// <param name="label">The label to look for, this is what is shown to the user.</param>
   void SelectByText(String text)
   {
     for(ListBoxRow item in _table.Children)
     {
       if (item.Text == text)
       {
         SelectedRow = item;
         return;
       }
     }
   }

   /// <summary>
   /// Selects the first menu item with the given internal name it finds.
   /// If a menu item can not be found that matches input, nothing happens.
   /// </summary>
   /// <param name="name">The internal name to look for. To select by what is displayed to the user, use "SelectByText".</param>
   void SelectByName(String name)
   {
     for(ListBoxRow item in _table.Children)
     {
       if (item.Name == name)
       {
         SelectedRow = item;
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
     for(ListBoxRow item in _table.Children)
     {
       if (userdata == null)
       {
         if (item.UserData == null)
         {
           SelectedRow = item;
           return;
         }
       }
       else if (userdata==item.UserData)
       {
         SelectedRow = item;
         return;
       }
     }
   }
   
   
   
}