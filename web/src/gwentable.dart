part of gwendart;

class GwenTable extends GwenControlBase
{
    bool _sizeToContents;
    int _columnCount;
    int _defaultRowHeight;
    int _maxWidth;
    
    List<int> _columnWidth;
    
    int get ColumnCount => _columnCount;
    set ColumnCount(int value) { SetColumnCount(value); Invalidate(); }
    
    int get RowCount => Children.length;
    
    int get DefaultRowHeight => _defaultRowHeight;
    set DefaultRowHeight ( int value) { _defaultRowHeight=value; }
    
    TableRow getRow(int index) { return Children[index] as TableRow; } 
    
    GwenTable(GwenControlBase parent) : super(parent)
    {
       _columnCount = 1;
       _defaultRowHeight = 22;
       _columnWidth = new List<int>(TableRow.MaxColumns);
       int i;
       for(i=0; i<TableRow.MaxColumns; i++)
       {
         _columnWidth[i]=20;
       }
       _sizeToContents = false;
       _maxWidth = 0;
    }

    /// <summary>
    /// Sets the number of columns.
    /// </summary>
    /// <param name="count">Number of columns.</param>
    void SetColumnCount(int count)
    {
      if (_columnCount == count) return;
      for (TableRow row in Children)
      {
        row.ColumnCount = count;
      }

      _columnCount = count;
    }

    /// <summary>
    /// Sets the column width (in pixels).
    /// </summary>
    /// <param name="column">Column index.</param>
    /// <param name="width">Column width.</param>
    void SetColumnWidth(int column, int width)
    {
      if (_columnWidth[column] == width) return;
      _columnWidth[column] = width;
      Invalidate();
    }

    /// <summary>
    /// Gets the column width (in pixels).
    /// </summary>
    /// <param name="column">Column index.</param>
    /// <returns>Column width.</returns>
    int _GetColumnWidth(int column)
    {
      return _columnWidth[column];
    }

    /// <summary>
    /// Adds a new empty row.
    /// </summary>
    /// <returns>Newly created row.</returns>
    TableRow AddRow()
    {
      TableRow row = new TableRow(this);
      row.ColumnCount = _columnCount;
      row.Height = _defaultRowHeight;
      row.Dock = Pos.Top;
      return row;
    }

    /// <summary>
    /// Adds a new row.
    /// </summary>
    /// <param name="row">Row to add.</param>
    void AddRowRow(TableRow row)
    {
      row.Parent = this;
      row.ColumnCount = _columnCount;
      row.Height = _defaultRowHeight;
      row.Dock = Pos.Top;
    }

    /// <summary>
    /// Adds a new row with specified text in first column.
    /// </summary>
    /// <param name="text">Text to add.</param>
    /// <returns>New row.</returns>
    TableRow AddRowString(String text)
    {
      var row = AddRow();
      row.SetCellText(0, text);
      return row;
    }

    /// <summary>
    /// Removes a row by reference.
    /// </summary>
    /// <param name="row">Row to remove.</param>
    void RemoveRow(TableRow row)
    {
      RemoveChild(row, true);
    }

    /// <summary>
    /// Removes a row by index.
    /// </summary>
    /// <param name="idx">Row index.</param>
    void RemoveRowIndex(int idx)
    {
      var row = Children[idx];
      RemoveRow(row as TableRow);
    }

    /// <summary>
    /// Removes all rows.
    /// </summary>
    void RemoveAll()
    {
      while (RowCount > 0)
        RemoveRowIndex(0);
    }

    /// <summary>
    /// Gets the index of a specified row.
    /// </summary>
    /// <param name="row">Row to search for.</param>
    /// <returns>Row index if found, -1 otherwise.</returns>
    int GetRowIndex(TableRow row)
    {
      return Children.indexOf(row);
    }

    /// <summary>
    /// Lays out the control's interior according to alignment, padding, dock etc.
    /// </summary>
    /// <param name="skin">Skin to use.</param>
    void Layout(GwenSkinBase skin)
    {
      super.Layout(skin);

      bool even = false;
      for(TableRow row in Children)
      {
        row.EvenRow = even;
        even = !even;
        for (int i = 0; i < _columnCount; i++)
        {
          row.SetColumnWidth(i, _columnWidth[i]);
        }
      }
    }

    void PostLayout(GwenSkinBase skin)
    {
      super.PostLayout(skin);
      if (_sizeToContents)
      {
        DoSizeToContents();
        _sizeToContents = false;
      }
    }

    /// <summary>
    /// Sizes to fit contents.
    /// </summary>
    void SizeToContents(int maxWidth)
    {
      bool bChange = (_maxWidth != maxWidth ) || !_sizeToContents;
      if(bChange)
      {
        _maxWidth = maxWidth;
        _sizeToContents = true;
        Invalidate();
      }
    }

    void DoSizeToContents()
    {
      int height = 0;
      int width = 0;

      for(TableRow row in Children)
      {
        row.SizeToContents(); // now all columns fit but only in this particular row

        for (int i = 0; i < ColumnCount; i++)
        {
          GwenControlBase cell = row._GetColumn(i);
          if (null != cell)
          {
            if (i < ColumnCount - 1 || _maxWidth == 0)
              _columnWidth[i] = max(_columnWidth[i], cell.Width + cell.Margin.Left + cell.Margin.Right);
            else
              _columnWidth[i] = _maxWidth - width; // last cell - fill
          }
        }
        height += row.Height;
      }

      // sum all column widths 
      for (int i = 0; i < ColumnCount; i++)
      {
        width += _columnWidth[i];
      }

      SetSize(width, height);
      //InvalidateParent();
    }
}